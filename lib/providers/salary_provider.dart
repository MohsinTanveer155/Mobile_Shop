import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/salary_record.dart';
import '../services/salary_service.dart';

final salaryServiceProvider = Provider<SalaryService>((ref) => SalaryService());

final salaryHistoryProvider = StreamProvider.family<List<SalaryRecord>, String>((ref, uid) {
  final service = ref.watch(salaryServiceProvider);
  return service.getSalaryHistory(uid);
});

final currentSalaryPreviewProvider = FutureProvider.family<SalaryRecord?, String>((ref, uid) async {
  final service = ref.read(salaryServiceProvider);
  return await service.getCurrentMonthPreview(uid, 0, 26);
});

class SalaryNotifier extends StateNotifier<void> {
  final SalaryService _service;

  SalaryNotifier(this._service) : super(null);

  Future<String> generateSalaryRecord({
    required String uid,
    required String staffName,
    required String monthYear,
    required double baseSalary,
    int totalWorkingDays = 26,
  }) async {
    return await _service.generateSalaryRecord(
      uid: uid,
      staffName: staffName,
      monthYear: monthYear,
      baseSalary: baseSalary,
      totalWorkingDays: totalWorkingDays,
    );
  }
}

final salaryNotifierProvider = StateNotifierProvider<SalaryNotifier, void>((ref) {
  final service = ref.watch(salaryServiceProvider);
  return SalaryNotifier(service);
});

