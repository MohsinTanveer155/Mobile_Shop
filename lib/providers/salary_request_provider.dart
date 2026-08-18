import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/salary_request.dart';
import '../services/salary_request_service.dart';

final salaryRequestServiceProvider = Provider<SalaryRequestService>((ref) => SalaryRequestService());

final mySalaryRequestsProvider = StreamProvider.family<List<SalaryRequest>, String>((ref, uid) {
  final service = ref.watch(salaryRequestServiceProvider);
  return service.getMySalaryRequests(uid);
});

final pendingSalaryRequestsProvider = StreamProvider<List<SalaryRequest>>((ref) {
  final service = ref.watch(salaryRequestServiceProvider);
  return service.getPendingSalaryRequests();
});

final allSalaryRequestsProvider = StreamProvider<List<SalaryRequest>>((ref) {
  final service = ref.watch(salaryRequestServiceProvider);
  return service.getAllSalaryRequests();
});

class SalaryRequestNotifier extends StateNotifier<void> {
  final SalaryRequestService _service;

  SalaryRequestNotifier(this._service) : super(null);

  Future<String> sendRequest({
    required String uid,
    required String employeeName,
    required double amount,
    required String reason,
  }) async {
    return await _service.applySalaryRequest(
      uid: uid,
      employeeName: employeeName,
      amount: amount,
      reason: reason,
    );
  }

  Future<void> updateStatus(
    String requestId,
    String status, {
    String? approvedBy,
    String? adminRemark,
    DateTime? paymentDate,
  }) async {
    await _service.updateSalaryRequestStatus(
      requestId,
      status,
      approvedBy: approvedBy,
      adminRemark: adminRemark,
      paymentDate: paymentDate,
    );
  }
}

final salaryRequestNotifierProvider = StateNotifierProvider<SalaryRequestNotifier, void>((ref) {
  final service = ref.watch(salaryRequestServiceProvider);
  return SalaryRequestNotifier(service);
});
