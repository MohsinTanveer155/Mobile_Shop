import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/customer.dart';
import '../models/customer_transaction.dart';
import '../models/sale.dart';

/// Service managing customer CRM, loyalty, credit, and backup.
/// Uses SharedPreferences for local persistence and supports export/import.
class CustomerService {
  static const String _customersKey = 'pos_customers';
  static const String _transactionsKey = 'pos_customer_transactions';

  final List<Customer> _customers = [];
  final List<CustomerTransaction> _transactions = [];

  List<Customer> get customers => List.unmodifiable(_customers);
  List<CustomerTransaction> get transactions => List.unmodifiable(_transactions);

  Future<void> initialize() async {
    await loadData();
  }

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final customersJson = prefs.getString(_customersKey);
      if (customersJson != null) {
        final List<dynamic> decoded = jsonDecode(customersJson);
        _customers.clear();
        _customers.addAll(
          decoded.map((item) => Customer.fromJson(item as Map<String, dynamic>)),
        );
      }

      final transactionsJson = prefs.getString(_transactionsKey);
      if (transactionsJson != null) {
        final List<dynamic> decoded = jsonDecode(transactionsJson);
        _transactions.clear();
        _transactions.addAll(
          decoded.map((item) => CustomerTransaction.fromJson(item as Map<String, dynamic>)),
        );
      }
    } catch (e) {
      // Handle silently
    }
  }

  Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customersJson = jsonEncode(_customers.map((c) => c.toJson()).toList());
      await prefs.setString(_customersKey, customersJson);

      final transactionsJson = jsonEncode(_transactions.map((t) => t.toJson()).toList());
      await prefs.setString(_transactionsKey, transactionsJson);
    } catch (e) {
      // Handle silently
    }
  }

  // ==================== CRUD ====================

  String _generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';
  }

  Customer addCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) {
    final now = DateTime.now();
    final customer = Customer(
      id: _generateId(),
      name: name,
      phone: phone,
      email: email,
      address: address,
      createdAt: now,
      updatedAt: now,
    );
    _customers.add(customer);
    saveData();
    return customer;
  }

  void updateCustomer(Customer updated) {
    final index = _customers.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      _customers[index] = updated;
      saveData();
    }
  }

  void deleteCustomer(String id) {
    _customers.removeWhere((c) => c.id == id);
    _transactions.removeWhere((t) => t.customerId == id);
    saveData();
  }

  Customer? findById(String id) {
    try {
      return _customers.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Customer> search(String query) {
    final lower = query.toLowerCase();
    return _customers.where((c) {
      return c.name.toLowerCase().contains(lower) ||
          c.phone.contains(lower);
    }).toList();
  }

  // ==================== LOYALTY ====================

  /// Earn loyalty points: 1 point per 10 currency units spent
  double calculateLoyaltyPoints(double amount) {
    return (amount / 10).floorToDouble();
  }

  void addLoyaltyPoints(String customerId, double points) {
    final customer = findById(customerId);
    if (customer != null) {
      customer.loyaltyPoints += points;
      customer.updatedAt = DateTime.now();
      saveData();
    }
  }

  void redeemLoyaltyPoints(String customerId, double points) {
    final customer = findById(customerId);
    if (customer != null && customer.loyaltyPoints >= points) {
      customer.loyaltyPoints -= points;
      customer.updatedAt = DateTime.now();
      saveData();
    }
  }

  double getLoyaltyDiscount(double points) {
    // 1 point = 1 currency unit discount
    return points;
  }

  // ==================== CREDIT ====================

  void addCredit(String customerId, double amount) {
    final customer = findById(customerId);
    if (customer != null) {
      customer.creditBalance += amount;
      customer.updatedAt = DateTime.now();

      final transaction = CustomerTransaction(
        id: _generateId(),
        customerId: customerId,
        amount: amount,
        date: DateTime.now(),
        type: 'credit_sale',
      );
      _transactions.add(transaction);
      saveData();
    }
  }

  void repayCredit(String customerId, double amount, {String? notes}) {
    final customer = findById(customerId);
    if (customer != null) {
      customer.creditBalance = (customer.creditBalance - amount).clamp(0, double.infinity);
      customer.updatedAt = DateTime.now();

      final transaction = CustomerTransaction(
        id: _generateId(),
        customerId: customerId,
        amount: amount,
        date: DateTime.now(),
        type: 'repayment',
        notes: notes,
      );
      _transactions.add(transaction);
      saveData();
    }
  }

  List<CustomerTransaction> getTransactionsForCustomer(String customerId) {
    return _transactions.where((t) => t.customerId == customerId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  double getTotalCreditForCustomer(String customerId) {
    return _transactions
        .where((t) => t.customerId == customerId && t.type == 'credit_sale')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double getTotalRepaymentsForCustomer(String customerId) {
    return _transactions
        .where((t) => t.customerId == customerId && t.type == 'repayment')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double getTotalPurchasesForCustomer(String customerId, List<Sale> sales) {
    return sales
        .where((sale) => sale.customerId == customerId)
        .fold(0.0, (total, sale) => total + sale.totalPrice);
  }

  double getDuePaymentsForCustomer(String customerId) {
    return findById(customerId)?.creditBalance ?? 0.0;
  }

  bool isRepeatCustomer(String customerId, List<Sale> sales) {
    final purchaseCount = sales.where((sale) => sale.customerId == customerId).length;
    return purchaseCount > 1;
  }

  List<String> getFavoriteProducts(String customerId, List<Sale> sales, {int limit = 3}) {
    final Map<String, int> productCount = {};
    for (final sale in sales.where((sale) => sale.customerId == customerId)) {
      productCount[sale.productName] = (productCount[sale.productName] ?? 0) + sale.quantity;
    }
    final sortedProducts = productCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedProducts.take(limit).map((entry) => entry.key).toList();
  }

  Map<String, dynamic> exportData() {
    return {
      'customers': _customers.map((c) => c.toJson()).toList(),
      'transactions': _transactions.map((t) => t.toJson()).toList(),
      'exportAt': DateTime.now().toIso8601String(),
    };
  }

  Future<void> importData(String jsonData, {bool merge = true}) async {
    final Map<String, dynamic> payload = jsonDecode(jsonData) as Map<String, dynamic>;
    final List<dynamic> customerList = payload['customers'] as List<dynamic>? ?? [];
    final List<dynamic> transactionList = payload['transactions'] as List<dynamic>? ?? [];

    if (!merge) {
      _customers.clear();
      _transactions.clear();
    }

    for (final dynamic raw in customerList) {
      final customer = Customer.fromJson(raw as Map<String, dynamic>);
      final index = _customers.indexWhere((c) => c.id == customer.id);
      if (index != -1) {
        _customers[index] = customer;
      } else {
        _customers.add(customer);
      }
    }

    for (final dynamic raw in transactionList) {
      final transaction = CustomerTransaction.fromJson(raw as Map<String, dynamic>);
      final exists = _transactions.any((t) => t.id == transaction.id);
      if (!exists) {
        _transactions.add(transaction);
      }
    }

    await saveData();
  }

  Future<void> clearData() async {
    _customers.clear();
    _transactions.clear();
    await saveData();
  }
}

