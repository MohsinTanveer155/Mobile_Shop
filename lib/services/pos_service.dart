import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/sale.dart';
import '../models/payment.dart';
import 'customer_service.dart';

/// POS service managing products and sales with local persistence.
/// Data is saved to SharedPreferences and survives app restarts.
class PosService {
  static const String _productsKey = 'pos_products';
  static const String _salesKey = 'pos_sales';

  final List<Product> products = [];
  final List<Sale> sales = [];
  final CustomerService customerService = CustomerService();

  /// Initialize by loading data from local storage
  Future<void> initialize() async {
    await customerService.initialize();
    await loadData();
  }

  /// Load products and sales from SharedPreferences
  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load products
      final productsJson = prefs.getString(_productsKey);
      if (productsJson != null) {
        final List<dynamic> decoded = jsonDecode(productsJson);
        products.clear();
        products.addAll(
          decoded.map((item) => Product.fromJson(item as Map<String, dynamic>))
        );
      }

      // Load sales
      final salesJson = prefs.getString(_salesKey);
      if (salesJson != null) {
        final List<dynamic> decoded = jsonDecode(salesJson);
        sales.clear();
        sales.addAll(
          decoded.map((item) => Sale.fromJson(item as Map<String, dynamic>))
        );
      }
    } catch (e) {
      // Handle error silently or log to analytics
    }
  }

  /// Save all data to SharedPreferences
  Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save products
      final productsJson = jsonEncode(
        products.map((p) => p.toJson()).toList()
      );
      await prefs.setString(_productsKey, productsJson);

      // Save sales
      final salesJson = jsonEncode(
        sales.map((s) => s.toJson()).toList()
      );
      await prefs.setString(_salesKey, salesJson);
    } catch (e) {
      // Handle error silently or log to analytics
    }
  }

  /// Generate a full backup payload including products, sales, and customer data.
  Map<String, dynamic> generateBackupPayload() {
    return {
      'products': products.map((p) => p.toJson()).toList(),
      'sales': sales.map((s) => s.toJson()).toList(),
      'customers': customerService.customers.map((c) => c.toJson()).toList(),
      'transactions': customerService.transactions.map((t) => t.toJson()).toList(),
      'backupAt': DateTime.now().toIso8601String(),
    };
  }

  /// Export the current app state as a JSON string for sharing or backup.
  Future<String> exportBackupJson() async {
    return jsonEncode(generateBackupPayload());
  }

  /// Import backup JSON and merge or replace local data.
  Future<void> importBackupJson(String jsonString, {bool merge = true}) async {
    final payload = jsonDecode(jsonString) as Map<String, dynamic>;
    await restoreFromBackupPayload(payload, merge: merge);
  }

  /// Restore data from a backup payload.
  Future<void> restoreFromBackupPayload(Map<String, dynamic> payload, {bool merge = true}) async {
    final productsList = payload['products'] as List<dynamic>? ?? [];
    final salesList = payload['sales'] as List<dynamic>? ?? [];
    final customersList = payload['customers'] as List<dynamic>? ?? [];
    final transactionsList = payload['transactions'] as List<dynamic>? ?? [];

    if (!merge) {
      products.clear();
      sales.clear();
      await customerService.clearData();
    }

    products.addAll(productsList.map((item) => Product.fromJson(item as Map<String, dynamic>)));
    sales.addAll(salesList.map((item) => Sale.fromJson(item as Map<String, dynamic>)));

    final backupCustomerJson = jsonEncode({
      'customers': customersList,
      'transactions': transactionsList,
    });
    await customerService.importData(backupCustomerJson, merge: merge);

    await saveData();
  }

  Product? findProductByBarcode(String barcode) {
    try {
      return products.firstWhere(
        (product) => product.barcode != null && product.barcode == barcode,
      );
    } catch (e) {
      return null;
    }
  }

  void addProduct(Product product) {
    products.add(product);
    saveData();
  }

  void updateProduct(Product updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
      saveData();
    }
  }

  void deleteProduct(String productId) {
    final index = products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      products.removeAt(index);
      saveData();
    }
  }

  Sale? sellProduct(Product product, int quantity, Payment payment) {
    return sellProductToCustomer(product, quantity, payment, null, 0.0, 0.0);
  }

  /// Sell product to a specific customer with loyalty and credit support.
  Sale? sellProductToCustomer(
    Product product,
    int quantity,
    Payment payment,
    String? customerId,
    double loyaltyPointsRedeemed,
    double creditAmount,
  ) {
    if (quantity <= 0 || quantity > product.quantity) {
      return null;
    }

    product.quantity -= quantity;
    final profit = product.profitPerUnit * quantity;
    final totalPrice = product.price * quantity;

    // Apply loyalty discount
    final finalTotalPrice = totalPrice - loyaltyPointsRedeemed;

    final sale = Sale(
      productName: product.name,
      quantity: quantity,
      totalPrice: finalTotalPrice > 0 ? finalTotalPrice : 0,
      profit: profit,
      date: DateTime.now(),
      payment: payment,
      customerId: customerId,
      loyaltyPointsEarned: customerId != null
          ? customerService.calculateLoyaltyPoints(totalPrice)
          : 0.0,
      loyaltyPointsRedeemed: loyaltyPointsRedeemed,
      creditAmount: creditAmount,
    );
    sales.add(sale);

    // Update customer if linked
    if (customerId != null) {
      // Add earned loyalty points
      if (sale.loyaltyPointsEarned > 0) {
        customerService.addLoyaltyPoints(customerId, sale.loyaltyPointsEarned);
      }

      // Deduct redeemed loyalty points
      if (loyaltyPointsRedeemed > 0) {
        customerService.redeemLoyaltyPoints(customerId, loyaltyPointsRedeemed);
      }

      // Add credit if applicable
      if (creditAmount > 0) {
        customerService.addCredit(customerId, creditAmount);
      }
    }

    saveData();
    return sale;
  }

  int get totalProducts => products.length;

  double get totalSales =>
      sales.fold(0.0, (previous, sale) => previous + sale.totalPrice);

  double get totalProfit =>
      sales.fold(0.0, (previous, sale) => previous + sale.profit);

  int get transactionCount => sales.length;

  int get totalQuantity => products.fold(0, (sum, product) => sum + product.quantity);

  // ==================== REPORT METHODS ====================

  /// Get sales within a date range [inclusive]
  List<Sale> getSalesInRange(DateTime start, DateTime end) {
    final startDay = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day, 23, 59, 59);
    return sales.where((sale) {
      return sale.date.isAfter(startDay.subtract(const Duration(seconds: 1))) &&
          sale.date.isBefore(endDay.add(const Duration(seconds: 1)));
    }).toList();
  }

  /// Daily report: last 7 days with sales, profit, and transaction counts
  List<Map<String, dynamic>> getDailyReportData() {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final start = DateTime(day.year, day.month, day.day);
      final end = DateTime(day.year, day.month, day.day, 23, 59, 59);
      final daySales = getSalesInRange(start, end);
      result.add({
        'label': '${day.day}/${day.month}',
        'sales': daySales.fold(0.0, (sum, s) => sum + s.totalPrice),
        'profit': daySales.fold(0.0, (sum, s) => sum + s.profit),
        'transactions': daySales.length,
      });
    }
    return result;
  }

  /// Weekly report: last 4 weeks
  List<Map<String, dynamic>> getWeeklyReportData() {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    for (int i = 3; i >= 0; i--) {
      final weekEnd = now.subtract(Duration(days: i * 7));
      final weekStart = weekEnd.subtract(const Duration(days: 6));
      final weekSales = getSalesInRange(weekStart, weekEnd);
      result.add({
        'label': 'W${4 - i}',
        'sales': weekSales.fold(0.0, (sum, s) => sum + s.totalPrice),
        'profit': weekSales.fold(0.0, (sum, s) => sum + s.profit),
        'transactions': weekSales.length,
      });
    }
    return result;
  }

  /// Monthly report: last 6 months
  List<Map<String, dynamic>> getMonthlyReportData() {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
      final monthSales = getSalesInRange(start, end);
      result.add({
        'label': '${month.month}/${month.year}',
        'sales': monthSales.fold(0.0, (sum, s) => sum + s.totalPrice),
        'profit': monthSales.fold(0.0, (sum, s) => sum + s.profit),
        'transactions': monthSales.length,
      });
    }
    return result;
  }

  /// Best selling products sorted by quantity sold
  List<Map<String, dynamic>> getBestSellingProducts({int limit = 5}) {
    final Map<String, Map<String, dynamic>> productMap = {};
    for (final sale in sales) {
      if (productMap.containsKey(sale.productName)) {
        productMap[sale.productName]!['quantity'] += sale.quantity;
        productMap[sale.productName]!['totalPrice'] += sale.totalPrice;
        productMap[sale.productName]!['profit'] += sale.profit;
      } else {
        productMap[sale.productName] = {
          'name': sale.productName,
          'quantity': sale.quantity,
          'totalPrice': sale.totalPrice,
          'profit': sale.profit,
        };
      }
    }
    final sorted = productMap.values.toList()
      ..sort((a, b) => (b['quantity'] as int).compareTo(a['quantity'] as int));
    return sorted.take(limit).toList();
  }

  /// Get profit data for chart based on period type
  List<Map<String, dynamic>> getProfitData(String periodType) {
    switch (periodType.toLowerCase()) {
      case 'daily':
        return getDailyReportData();
      case 'weekly':
        return getWeeklyReportData();
      case 'monthly':
        return getMonthlyReportData();
      default:
        return getDailyReportData();
    }
  }
}
