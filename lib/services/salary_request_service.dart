import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/salary_request.dart';
import 'firestore_error_handler.dart';

class SalaryRequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'salary_requests';

  Future<String> applySalaryRequest({
    required String uid,
    required String employeeName,
    required double amount,
    required String reason,
  }) async {
    return runFirestoreOperation(() async {
      final docRef = _firestore.collection(_collection).doc();
      await docRef.set({
        'uid': uid,
        'employeeName': employeeName,
        'requestDate': FieldValue.serverTimestamp(),
        'amount': amount,
        'reason': reason,
        'status': 'pending',
        'adminRemark': null,
        'approvedBy': null,
        'paymentDate': null,
      });
      return docRef.id;
    }, context: 'SalaryRequestService.applySalaryRequest');
  }

  Stream<List<SalaryRequest>> getMySalaryRequests(String uid) {
    return _firestore
        .collection(_collection)
        .where('uid', isEqualTo: uid)
        .orderBy('requestDate', descending: true)
        .snapshots()
        .handleError((error, stackTrace) {
          logFirestoreError(error, stackTrace as StackTrace?, context: 'SalaryRequestService.getMySalaryRequests');
        })
        .map((snapshot) => snapshot.docs
            .map((doc) => SalaryRequest.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                }))
            .toList());
  }

  Stream<List<SalaryRequest>> getPendingSalaryRequests() {
    return _firestore
        .collection(_collection)
        .where('status', isEqualTo: 'pending')
        .orderBy('requestDate', descending: true)
        .snapshots()
        .handleError((error, stackTrace) {
          logFirestoreError(error, stackTrace as StackTrace?, context: 'SalaryRequestService.getPendingSalaryRequests');
        })
        .map((snapshot) => snapshot.docs
            .map((doc) => SalaryRequest.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                }))
            .toList());
  }

  Stream<List<SalaryRequest>> getAllSalaryRequests() {
    return _firestore
        .collection(_collection)
        .orderBy('requestDate', descending: true)
        .snapshots()
        .handleError((error, stackTrace) {
          logFirestoreError(error, stackTrace as StackTrace?, context: 'SalaryRequestService.getAllSalaryRequests');
        })
        .map((snapshot) => snapshot.docs
            .map((doc) => SalaryRequest.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                }))
            .toList());
  }

  Future<void> updateSalaryRequestStatus(
    String requestId,
    String status, {
    String? approvedBy,
    String? adminRemark,
    DateTime? paymentDate,
  }) async {
    return runFirestoreOperation(() async {
      final updates = <String, dynamic>{
        'status': status,
        'adminRemark': adminRemark,
      };
      if (approvedBy != null) updates['approvedBy'] = approvedBy;
      if (paymentDate != null) updates['paymentDate'] = paymentDate;

      await _firestore.collection(_collection).doc(requestId).update(updates);
    }, context: 'SalaryRequestService.updateSalaryRequestStatus');
  }
}
