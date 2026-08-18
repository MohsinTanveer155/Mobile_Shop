import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/leave_request.dart';
import 'firestore_error_handler.dart';

class LeaveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Apply for leave (staff)
  Future<String> applyLeave({
    required String uid,
    required String staffName,
    required String type,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  }) async {
    return runFirestoreOperation(() async {
      final leaveId = _firestore.collection('leave_requests').doc().id;
      final totalDays = endDate.difference(startDate).inDays + 1;

      await _firestore.collection('leave_requests').doc(leaveId).set({
        'id': leaveId,
        'uid': uid,
        'staffName': staffName,
        'type': type,
        'startDate': startDate,
        'endDate': endDate,
        'reason': reason,
        'status': 'pending',
        'adminRemark': null,
        'totalDays': totalDays,
      });

      return leaveId;
    }, context: 'LeaveService.applyLeave');
  }

  /// Get my leaves (staff)
  Stream<List<LeaveRequest>> getMyLeaves(String uid) {
    return _firestore
        .collection('leave_requests')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .handleError((error, stackTrace) {
          logFirestoreError(error, stackTrace as StackTrace?, context: 'LeaveService.getMyLeaves');
        })
        .map((snapshot) {
          final leaves = snapshot.docs
              .map((doc) => LeaveRequest.fromJson({
                    ...doc.data(),
                    'id': doc.id,
                  }))
              .toList();
          leaves.sort((a, b) => b.startDate.compareTo(a.startDate));
          return leaves;
        });
  }

  /// Get pending leaves for admin approval
  Stream<List<LeaveRequest>> getPendingLeaves() {
    return _firestore
        .collection('leave_requests')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .handleError((error, stackTrace) {
          logFirestoreError(error, stackTrace as StackTrace?, context: 'LeaveService.getPendingLeaves');
        })
        .map((snapshot) {
          final leaves = snapshot.docs
              .map((doc) => LeaveRequest.fromJson({
                    ...doc.data(),
                    'id': doc.id,
                  }))
              .toList();
          leaves.sort((a, b) => a.startDate.compareTo(b.startDate));
          return leaves;
        });
  }

  /// Approve/Reject leave (admin)
  Future<void> updateLeaveStatus(String leaveId, String status, {String? approvedByUid, String? adminRemark}) async {
    return runFirestoreOperation(() async {
      final updates = <String, dynamic>{
        'status': status,
        'adminRemark': adminRemark,
      };
      if (status != 'pending' && approvedByUid != null) {
        updates['approvedBy'] = approvedByUid;
        updates['approvedAt'] = FieldValue.serverTimestamp();
      }

      await _firestore.collection('leave_requests').doc(leaveId).update(updates);
    }, context: 'LeaveService.updateLeaveStatus');
  }
}



