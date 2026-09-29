import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/salary_request.dart';
import 'auth_provider.dart';
import 'salary_provider.dart';

final staffSalaryRequestsProvider = StreamProvider<List<SalaryRequest>>((ref) {
  final user = ref.watch(authProvider);
  final salaryService = ref.watch(salaryServiceProvider);

  if (user == null) {
    return Stream.value([]);
  }
  return salaryService.getStaffSalaryRequestsStream(user.id);
});

final adminSalaryRequestsProvider = StreamProvider<List<SalaryRequest>>((ref) {
  final salaryService = ref.watch(salaryServiceProvider);
  return salaryService.getAdminSalaryRequestsStream();
});

/// Pending salary requests for admin dashboard summaries.
final pendingSalaryRequestsProvider = adminSalaryRequestsProvider;
