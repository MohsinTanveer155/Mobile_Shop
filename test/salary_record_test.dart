import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_shop/models/salary_record.dart';

void main() {
  group('SalaryRecord.fromJson', () {
    test('accepts Timestamp generatedAt values from Firestore', () {
      final now = DateTime(2025, 1, 15, 9, 30);
      final record = SalaryRecord.fromJson({
        'uid': 'user-123',
        'staffName': 'Ali Khan',
        'monthYear': '2025-01',
        'baseSalary': 30000,
        'totalWorkingDays': 26,
        'presentDays': 24,
        'deductions': 1500,
        'netPay': 28500,
        'generatedAt': Timestamp.fromDate(now),
      });

      expect(record.uid, 'user-123');
      expect(record.staffName, 'Ali Khan');
      expect(record.generatedAt, now);
    });

    test('accepts DateTime generatedAt values from older or local data', () {
      final now = DateTime(2025, 1, 15, 9, 30);
      final record = SalaryRecord.fromJson({
        'uid': 'user-123',
        'staffName': 'Ali Khan',
        'monthYear': '2025-01',
        'baseSalary': 30000,
        'totalWorkingDays': 26,
        'presentDays': 24,
        'deductions': 1500,
        'netPay': 28500,
        'generatedAt': now,
      });

      expect(record.generatedAt, now);
    });
  });
}
