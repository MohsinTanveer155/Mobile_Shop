import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sale.dart';

/// Firebase service for backup, sync, and cloud storage.
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Initialize Firebase, FirebaseAuth, Firestore, or Realtime Database here.
  Future<void> initialize() async {
    // Firebase.initializeApp() is invoked in main.dart, so no work needed here.
  }

  /// Save product data to Firebase Firestore.
  Future<void> saveProduct(Map<String, dynamic> productData) async {
    await _firestore.collection('products').doc(productData['name']).set(productData);
  }

  /// Save sale transaction data to Firebase.
  Future<void> saveSale(Map<String, dynamic> saleData) async {
    await _firestore.collection('sales').add(saleData);
  }

  /// Sync a single sale to Firebase after local transaction.
  Future<void> syncSale(Sale sale) async {
    await saveSale(sale.toJson());
  }

  /// Backup a full app payload to Firebase.
  Future<void> backupData(Map<String, dynamic> payload, {String? documentId}) async {
    final id = documentId ?? DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore.collection('backups').doc(id).set(payload);
  }

  /// Restore backup payload from Firebase.
  Future<Map<String, dynamic>?> restoreBackup(String documentId) async {
    final snapshot = await _firestore.collection('backups').doc(documentId).get();
    return snapshot.exists ? snapshot.data() : null;
  }

  /// List available backup documents.
  Future<List<String>> listBackups() async {
    final snapshot = await _firestore.collection('backups').get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  /// Fetch sales from Firebase within a date range for reports.
  /// Returns raw JSON maps that can be converted to [Sale] objects.
  Future<List<Map<String, dynamic>>> fetchSalesReport(
    DateTime start,
    DateTime end,
  ) async {
    final startId = start.toIso8601String();
    final endId = end.toIso8601String();
    final snapshot = await _firestore
        .collection('sales')
        .where('date', isGreaterThanOrEqualTo: startId)
        .where('date', isLessThanOrEqualTo: endId)
        .get();

    return snapshot.docs.map((d) => d.data()).cast<Map<String, dynamic>>().toList();
  }

  /// Stream of real-time sales updates for live dashboards.
  Stream<List<Map<String, dynamic>>> salesStream() {
    return _firestore
        .collection('sales')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((d) => d.data()).cast<Map<String, dynamic>>().toList());
  }
}

