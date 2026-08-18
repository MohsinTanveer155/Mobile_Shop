import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/salary_record.dart';
// import '../models/user.dart';
import 'attendance_service.dart';

class SalaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AttendanceService _attendanceService = AttendanceService();

  /// Generate salary record for month (admin or auto)
  Future<String> generateSalaryRecord({
    required String uid,
    required String staffName,
    required String monthYear,
    required double baseSalary,
    int totalWorkingDays = 26, // Standard working days
  }) async {
    final presentDays = await _attendanceService.getPresentDays(uid, monthYear);
    final dailyRate = baseSalary / totalWorkingDays;
    final grossPay = dailyRate * presentDays;
    final netPay = grossPay; // Add deductions logic later

    final salaryId = _firestore.collection('salaries').doc(uid).collection('months').doc(monthYear).id;

    await _firestore
        .collection('salaries')
        .doc(uid)
        .collection('months')
        .doc(monthYear)
        .set({
      'uid': uid,
      'staffName': staffName,
      'monthYear': monthYear,
      'baseSalary': baseSalary,
      'totalWorkingDays': totalWorkingDays,
      'presentDays': presentDays,
      'deductions': 0.0,
      'netPay': netPay,
      'generatedAt': FieldValue.serverTimestamp(),
    });

    return salaryId;
  }

  /// Get salary history
  Stream<List<SalaryRecord>> getSalaryHistory(String uid) {
    return _firestore
        .collection('salaries')
        .doc(uid)
        .collection('months')
        .orderBy('monthYear', descending: true)
        .limit(12)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SalaryRecord.fromJson({
                  ...doc.data(),
                  'generatedAt': doc['generatedAt'],
                }))
            .toList());
  }

  /// Get current month preview
  Future<SalaryRecord?> getCurrentMonthPreview(String uid, double baseSalary, int totalDays) async {
    final now = DateTime.now();
    final monthYear = DateFormat('yyyy-MM').format(now);
    final presentDays = await _attendanceService.getPresentDays(uid, monthYear);
    
    return SalaryRecord(
      uid: uid,
      staffName: '', // Fetch from user
      monthYear: monthYear,
      baseSalary: baseSalary,
      totalWorkingDays: totalDays,
      presentDays: presentDays,
      netPay: (baseSalary / totalDays) * presentDays,
      generatedAt: now,
    );
  }
}
