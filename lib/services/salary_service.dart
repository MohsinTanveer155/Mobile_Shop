import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/salary_request.dart';
import '../models/salary_record.dart';

class SalaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _requestsCollectionName = 'salary_requests';
  static const String _recordsCollectionName = 'salary_records';

  CollectionReference<SalaryRequest> get _salaryRequestsCollection {
    return _firestore
        .collection(_requestsCollectionName)
        .withConverter<SalaryRequest>(
          fromFirestore: (snapshot, _) => SalaryRequest.fromJson(snapshot.data()!),
          toFirestore: (request, _) => request.toJson(),
        );
  }

  CollectionReference<SalaryRecord> get _salaryRecordsCollection {
    return _firestore
        .collection(_recordsCollectionName)
        .withConverter<SalaryRecord>(
          fromFirestore: (snapshot, _) =>
              SalaryRecord.fromJson(snapshot.data()!),
          toFirestore: (record, _) => record.toJson(),
        );
  }

  Future<void> createSalaryRequest(SalaryRequest request) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw FirebaseAuthException(
          code: 'unauthenticated',
          message: 'You must be signed in to submit a salary request.',
        );
      }

      await _firestore.collection(_requestsCollectionName).doc(request.id).set({
        ...request.toJson(),
        'staffId': currentUser.uid,
        'requestDate': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException {
      rethrow;
    }
  }

  Stream<List<SalaryRequest>> getStaffSalaryRequestsStream(String staffId) {
    return _salaryRequestsCollection
        .where('staffId', isEqualTo: staffId)
        .snapshots()
        .map((snapshot) {
          final requests = snapshot.docs.map((doc) => doc.data()).toList();
          requests.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return requests;
        });
  }

  Stream<List<SalaryRequest>> getAdminSalaryRequestsStream() {
    return _salaryRequestsCollection
        .where('status', isEqualTo: SalaryRequestStatus.pending.name)
        .snapshots()
        .map((snapshot) {
          final requests = snapshot.docs.map((doc) => doc.data()).toList();
          requests.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return requests;
        });
  }

  Future<void> updateSalaryRequestStatus({
    required String requestId,
    required SalaryRequestStatus status,
    String? adminRemark,
  }) async {
    try {
      await _salaryRequestsCollection.doc(requestId).update({
        'status': status.name,
        'adminRemark': adminRemark,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update salary request status: $e');
    }
  }

  Future<SalaryRequest?> getSalaryRequestById(String requestId) async {
    try {
      final doc = await _salaryRequestsCollection.doc(requestId).get();
      return doc.data();
    } catch (e) {
      debugPrint('Error getting salary request: $e');
      return null;
    }
  }

  Future<void> deleteSalaryRequest(String requestId) async {
    try {
      await _salaryRequestsCollection.doc(requestId).delete();
    } catch (e) {
      throw Exception('Failed to delete salary request: $e');
    }
  }

  // --- Methods for Salary Records ---

  Stream<List<SalaryRecord>> getSalaryHistory(String uid) {
    return _salaryRecordsCollection
        .where('uid', isEqualTo: uid)
        .orderBy('generatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<SalaryRecord?> getCurrentMonthPreview(
      String uid, int deductions, int totalWorkingDays) async {
    // This is a placeholder implementation.
    // In a real app, you would fetch the staff's base salary,
    // calculate deductions based on attendance, leaves, etc.
    // For now, it returns a dummy preview record.
    const double baseSalary = 30000;
    const double calculatedDeductions = 1500;
    return SalaryRecord(
      uid: uid,
      staffName: 'Staff Preview', // You might want to fetch the actual name
      monthYear: 'Preview',
      baseSalary: baseSalary,
      totalWorkingDays: 26,
      presentDays: 24, // Example value
      deductions: calculatedDeductions,
      netPay: baseSalary - calculatedDeductions,
      generatedAt: DateTime.now(),
    );
  }

  Future<String> generateSalaryRecord({
    required String uid,
    required String staffName,
    required String monthYear,
    required double baseSalary,
    int totalWorkingDays = 26,
    // Add other params like deductions, bonus etc.
  }) async {
    // Assuming full attendance for generated record, can be adjusted
    final int presentDays = totalWorkingDays;
    final double netSalary = baseSalary; // Assuming no deductions for now

    final record = SalaryRecord(
        uid: uid, staffName: staffName, monthYear: monthYear, baseSalary: baseSalary, totalWorkingDays: totalWorkingDays, presentDays: presentDays, netPay: netSalary, generatedAt: DateTime.now());

    // SalaryRecord model does not have an 'id' field. Use `add` to let Firestore auto-generate it.
    final docRef = await _salaryRecordsCollection.add(record);
    return docRef.id;
  }
}