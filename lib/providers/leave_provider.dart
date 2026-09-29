import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/leave_service.dart';
import '../models/leave_request.dart';

final leaveServiceProvider = Provider<LeaveService>((ref) => LeaveService());

final myLeavesProvider = StreamProvider.family<List<LeaveRequest>, String>((ref, uid) {
  if (uid.isEmpty) {
    return Stream.value(const <LeaveRequest>[]);
  }
  final service = ref.watch(leaveServiceProvider);
  return service.getMyLeaves(uid);
});

final pendingLeavesProvider = StreamProvider<List<LeaveRequest>>((ref) {
  final service = ref.watch(leaveServiceProvider);
  return service.getPendingLeaves();
});

class LeaveNotifier extends StateNotifier<void> {
  final LeaveService _service;

  LeaveNotifier(this._service) : super(null);

  Future<String> applyLeave({
    required String uid,
    required String staffName,
    required String type,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  }) async {
    return await _service.applyLeave(
      uid: uid,
      staffName: staffName,
      type: type,
      startDate: startDate,
      endDate: endDate,
      reason: reason,
    );
  }

  Future<void> updateLeaveStatus(String leaveId, String status, {String? approvedByUid, String? adminRemark}) async {
    await _service.updateLeaveStatus(leaveId, status, approvedByUid: approvedByUid, adminRemark: adminRemark);
  }
}

final leaveNotifierProvider = StateNotifierProvider<LeaveNotifier, void>((ref) {
  final service = ref.watch(leaveServiceProvider);
  return LeaveNotifier(service);
});
