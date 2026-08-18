import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/warranty_record.dart';

/// Service managing warranty records for sold products.
/// Tracks warranty periods, expiry dates, and claim processing.
class WarrantyService {
  static const String _warrantyKey = 'pos_warranty_records';

  final List<WarrantyRecord> _records = [];

  List<WarrantyRecord> get records => List.unmodifiable(_records);

  Future<void> initialize() async {
    await loadData();
  }

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final warrantyJson = prefs.getString(_warrantyKey);
      if (warrantyJson != null) {
        final List<dynamic> decoded = jsonDecode(warrantyJson);
        _records.clear();
        _records.addAll(
          decoded.map((item) => WarrantyRecord.fromJson(item as Map<String, dynamic>)),
        );
      }
    } catch (e) {
      // Handle silently
    }
  }

  Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final warrantyJson = jsonEncode(_records.map((r) => r.toJson()).toList());
      await prefs.setString(_warrantyKey, warrantyJson);
    } catch (e) {
      // Handle silently
    }
  }

  // ==================== CRUD ====================

  String _generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';
  }

  /// Create a new warranty record when product is sold
  WarrantyRecord createWarranty({
    required String productName,
    String? customerId,
    String? customerName,
    String? customerPhone,
    required DateTime purchaseDate,
    int warrantyMonths = 12,
  }) {
    final record = WarrantyRecord(
      id: _generateId(),
      productName: productName,
      customerId: customerId,
      customerName: customerName,
      customerPhone: customerPhone,
      purchaseDate: purchaseDate,
      warrantyMonths: warrantyMonths,
      status: WarrantyStatus.active,
      createdAt: DateTime.now(),
    );
    _records.add(record);
    saveData();
    return record;
  }

  /// Find warranty by ID
  WarrantyRecord? findById(String id) {
    try {
      return _records.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all warranties for a customer
  List<WarrantyRecord> getByCustomer(String customerId) {
    return _records.where((r) => r.customerId == customerId).toList();
  }

  /// Get active warranties
  List<WarrantyRecord> getActive() {
    return _records.where((r) {
      return r.status == WarrantyStatus.active && !r.isExpired;
    }).toList();
  }

  /// Get expired warranties
  List<WarrantyRecord> getExpired() {
    return _records.where((r) {
      return r.status == WarrantyStatus.active && r.isExpired;
    }).toList();
  }

  /// Get warranties expiring soon (within given days)
  List<WarrantyRecord> getExpiringSoon({int days = 30}) {
    final now = DateTime.now();
    return _records.where((r) {
      if (r.status != WarrantyStatus.active) return false;
      if (r.isExpired) return false;
      return r.expiryDate.difference(now).inDays <= days;
    }).toList();
  }

  /// Process a warranty claim
  void fileClaim(String warrantyId, String issue, {String? resolution, double? cost}) {
    final record = findById(warrantyId);
    if (record != null) {
      final claim = WarrantyClaim(
        id: _generateId(),
        date: DateTime.now(),
        issue: issue,
        resolution: resolution,
        cost: cost,
        claimStatus: ClaimStatus.pending,
      );
      record.claimHistory.add(claim);
      record.status = WarrantyStatus.claimed;
      record.updatedAt = DateTime.now();
      saveData();
    }
  }

  /// Resolve a claim
  void resolveClaim(String warrantyId, String claimId, String resolution, {double? cost, ClaimStatus status = ClaimStatus.resolved}) {
    final record = findById(warrantyId);
    if (record != null) {
      final claim = record.claimHistory.firstWhere((c) => c.id == claimId);
      claim.resolution = resolution;
      claim.cost = cost;
      claim.claimStatus = status;
      record.updatedAt = DateTime.now();
      saveData();
    }
  }

  /// Void a warranty
  void voidWarranty(String warrantyId, {String? reason}) {
    final record = findById(warrantyId);
    if (record != null) {
      record.status = WarrantyStatus.void_;
      record.updatedAt = DateTime.now();
      saveData();
    }
  }

  /// Delete warranty record
  void deleteWarranty(String id) {
    _records.removeWhere((r) => r.id == id);
    saveData();
  }

  /// Search warranties
  List<WarrantyRecord> search(String query) {
    final lower = query.toLowerCase();
    return _records.where((r) {
      return r.productName.toLowerCase().contains(lower) ||
          (r.customerName?.toLowerCase().contains(lower) ?? false) ||
          (r.customerPhone?.contains(lower) ?? false);
    }).toList();
  }

  /// Get warranty statistics
  Map<String, int> getStatistics() {
    return {
      'total': _records.length,
      'active': getActive().length,
      'expired': getExpired().length,
      'claimed': _records.where((r) => r.status == WarrantyStatus.claimed).length,
      'void': _records.where((r) => r.status == WarrantyStatus.void_).length,
    };
  }
}

