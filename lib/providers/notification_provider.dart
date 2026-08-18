import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notification_service.dart';
import '../services/pos_service.dart';

/// State class for notification preferences
class NotificationState {
  final bool notificationsEnabled;
  final bool lowStockEnabled;
  final bool dailyReminderEnabled;
  final int lowStockThreshold;

  const NotificationState({
    this.notificationsEnabled = false,
    this.lowStockEnabled = true,
    this.dailyReminderEnabled = true,
    this.lowStockThreshold = 20,
  });

  NotificationState copyWith({
    bool? notificationsEnabled,
    bool? lowStockEnabled,
    bool? dailyReminderEnabled,
    int? lowStockThreshold,
  }) {
    return NotificationState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      lowStockEnabled: lowStockEnabled ?? this.lowStockEnabled,
      dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
    );
  }
}

/// Riverpod state notifier for notification settings
class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationService _service;

  NotificationNotifier(this._service) : super(const NotificationState());

  /// Request notification permissions
  Future<bool> requestPermissions() async {
    final granted = await _service.requestPermissions();
    state = state.copyWith(notificationsEnabled: granted);
    return granted;
  }

  /// Toggle low stock notifications
  void toggleLowStock(bool value) {
    state = state.copyWith(lowStockEnabled: value);
  }

  /// Toggle daily reminder
  void toggleDailyReminder(bool value) {
    state = state.copyWith(dailyReminderEnabled: value);
  }

  /// Set low stock threshold
  void setLowStockThreshold(int value) {
    state = state.copyWith(lowStockThreshold: value);
  }

  /// Show daily sales reminder if enabled
  Future<void> showDailyReminder(PosService posService) async {
    if (!state.notificationsEnabled || !state.dailyReminderEnabled) return;
    await _service.showDailyReminderIfNeeded(posService);
  }

  /// Check and notify for low stock products
  Future<void> checkLowStock(PosService posService) async {
    if (!state.notificationsEnabled || !state.lowStockEnabled) return;
    await _service.checkLowStock(
      posService.products,
      threshold: state.lowStockThreshold,
    );
  }
}

/// Provider for NotificationService instance
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// Provider for notification state management
final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final service = ref.watch(notificationServiceProvider);
  return NotificationNotifier(service);
});
