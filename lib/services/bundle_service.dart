import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_bundle.dart';
import '../models/product.dart';

/// Service managing product bundles.
/// Bundles combine multiple products at a discounted price.
class BundleService {
  static const String _bundlesKey = 'pos_product_bundles';

  final List<ProductBundle> _bundles = [];

  List<ProductBundle> get bundles => List.unmodifiable(_bundles);

  Future<void> initialize() async {
    await loadData();
  }

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bundlesJson = prefs.getString(_bundlesKey);
      if (bundlesJson != null) {
        final List<dynamic> decoded = jsonDecode(bundlesJson);
        _bundles.clear();
        _bundles.addAll(
          decoded.map((item) => ProductBundle.fromJson(item as Map<String, dynamic>)),
        );
      }
    } catch (e) {
      // Handle silently
    }
  }

  Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bundlesJson = jsonEncode(_bundles.map((b) => b.toJson()).toList());
      await prefs.setString(_bundlesKey, bundlesJson);
    } catch (e) {
      // Handle silently
    }
  }

  // ==================== CRUD ====================

  String _generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';
  }

  /// Create a new product bundle
  ProductBundle createBundle({
    required String name,
    String? description,
    required List<BundleItem> items,
    double discountPercent = 0.0,
  }) {
    final bundle = ProductBundle(
      id: _generateId(),
      name: name,
      description: description,
      items: items,
      discountPercent: discountPercent,
      createdAt: DateTime.now(),
    );
    _bundles.add(bundle);
    saveData();
    return bundle;
  }

  /// Find bundle by ID
  ProductBundle? findById(String id) {
    try {
      return _bundles.firstWhere((b) => b.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update bundle
  void updateBundle(ProductBundle updated) {
    final index = _bundles.indexWhere((b) => b.id == updated.id);
    if (index != -1) {
      _bundles[index] = updated;
      saveData();
    }
  }

  /// Delete bundle
  void deleteBundle(String id) {
    _bundles.removeWhere((b) => b.id == id);
    saveData();
  }

  /// Search bundles
  List<ProductBundle> search(String query) {
    final lower = query.toLowerCase();
    return _bundles.where((b) {
      return b.name.toLowerCase().contains(lower) ||
          (b.description?.toLowerCase().contains(lower) ?? false);
    }).toList();
  }

  /// Check if bundle can be sold (all products have sufficient stock)
  bool canSellBundle(ProductBundle bundle, List<Product> availableProducts) {
    for (final item in bundle.items) {
      final product = availableProducts.firstWhere(
        (p) => p.name == item.productName,
        orElse: () => Product(name: '', price: 0, quantity: 0),
      );
      if (product.name.isEmpty || product.quantity < item.quantity) {
        return false;
      }
    }
    return true;
  }

  /// Get bundle statistics
  Map<String, dynamic> getStatistics() {
    final totalBundles = _bundles.length;
    final totalValue = _bundles.fold(0.0, (sum, b) => sum + b.finalPrice);
    final avgDiscount = totalBundles > 0
        ? _bundles.fold(0.0, (sum, b) => sum + b.discountPercent) / totalBundles
        : 0.0;

    return {
      'totalBundles': totalBundles,
      'totalValue': totalValue,
      'averageDiscount': avgDiscount,
    };
  }
}

