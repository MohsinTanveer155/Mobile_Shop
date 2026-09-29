import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'pos_service.dart';

/// Service handling local notifications for the POS app.
/// Manages low stock warnings and daily sales reminders.
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Initialize notification plugin with platform-specific settings
  Future<void> initialize() async {
    if (_initialized) return;

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    if (!kIsWeb && Platform.isAndroid) {
      await _createNotificationChannels();
    }

    _initialized = true;
  }

  /// Request notification permissions from the user
  Future<bool> requestPermissions() async {
    if (!kIsWeb && Platform.isIOS) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return result ?? false;
    } else if (!kIsWeb && Platform.isAndroid) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      return result ?? false;
    }
    return false;
  }

  /// Create Android notification channels
  Future<void> _createNotificationChannels() async {
    const AndroidNotificationChannel lowStockChannel = AndroidNotificationChannel(
      'low_stock_channel',
      'Low Stock Alerts',
      description: 'Notifications when product inventory is running low',
      importance: Importance.high,
    );

    const AndroidNotificationChannel dailyReminderChannel = AndroidNotificationChannel(
      'daily_reminder_channel',
      'Daily Sales Reminders',
      description: 'Daily summary of sales and store performance',
      importance: Importance.defaultImportance,
    );

    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(lowStockChannel);
    await androidPlugin?.createNotificationChannel(dailyReminderChannel);
  }

  /// Show a low stock warning notification
  Future<void> showLowStockNotification(Product product) async {
    if (!_initialized) await initialize();

    await _notifications.show(
      product.name.hashCode,
      'Low Stock Alert',
      '${product.name} is running low (${product.quantity} left). Please restock soon.',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'low_stock_channel',
          'Low Stock Alerts',
          channelDescription: 'Notifications when product inventory is running low',
          importance: Importance.high,
          priority: Priority.high,
          color: Colors.orange,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  /// Show daily sales reminder notification
  Future<void> showDailySalesReminder(PosService posService) async {
    if (!_initialized) await initialize();

    final today = DateTime.now();
    final todaySales = posService.sales.where((sale) {
      return sale.date.year == today.year &&
          sale.date.month == today.month &&
          sale.date.day == today.day;
    }).toList();

    final totalSales = todaySales.fold(0.0, (sum, s) => sum + s.totalPrice);
    final totalProfit = todaySales.fold(0.0, (sum, s) => sum + s.profit);
    final transactionCount = todaySales.length;

    String body;
    if (transactionCount == 0) {
      body = 'No sales recorded today yet. Let\'s make some sales!';
    } else {
      body = 'Today: $transactionCount transactions, '
          'Rs ${totalSales.toStringAsFixed(2)} sales, '
          'Rs ${totalProfit.toStringAsFixed(2)} profit.';
    }

    await _notifications.show(
      1000,
      'Daily Sales Summary',
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Sales Reminders',
          channelDescription: 'Daily summary of sales and store performance',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          color: Colors.indigo,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  /// Check for low stock products and show notifications
  Future<void> checkLowStock(List<Product> products, {int threshold = 5}) async {
    if (!_initialized) await initialize();

    for (final product in products) {
      if (product.quantity <= threshold && product.quantity > 0) {
        await showLowStockNotification(product);
      }
    }
  }

  /// Check if daily reminder was already shown today
  Future<bool> wasDailyReminderShownToday() async {
    final prefs = await SharedPreferences.getInstance();
    final lastShown = prefs.getString('last_daily_reminder');
    if (lastShown == null) return false;

    final lastDate = DateTime.tryParse(lastShown);
    if (lastDate == null) return false;

    final now = DateTime.now();
    return lastDate.year == now.year &&
        lastDate.month == now.month &&
        lastDate.day == now.day;
  }

  /// Mark daily reminder as shown
  Future<void> markDailyReminderShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_daily_reminder', DateTime.now().toIso8601String());
  }

  /// Show daily reminder if not already shown today
  Future<void> showDailyReminderIfNeeded(PosService posService) async {
    if (await wasDailyReminderShownToday()) return;
    await showDailySalesReminder(posService);
    await markDailyReminderShown();
  }

  /// Handle notification tap
  void _onNotificationTap(NotificationResponse response) {
    // In a real app, navigate to the relevant screen based on notification payload
  }
}

