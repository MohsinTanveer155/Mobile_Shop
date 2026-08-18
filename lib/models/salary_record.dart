import 'package:cloud_firestore/cloud_firestore.dart';

class SalaryRecord {
  final String uid;
  final String staffName;
  final String monthYear; // YYYY-MM
  final double baseSalary;
  final int totalWorkingDays;
  final int presentDays;
  final double deductions;
  final double netPay;
  final DateTime generatedAt;

  const SalaryRecord({
    required this.uid,
    required this.staffName,
    required this.monthYear,
    required this.baseSalary,
    required this.totalWorkingDays,
    required this.presentDays,
    this.deductions = 0.0,
    required this.netPay,
    required this.generatedAt,
  });

  double get attendancePercentage => totalWorkingDays > 0 
    ? (presentDays / totalWorkingDays) * 100 
    : 0;

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'staffName': staffName,
    'monthYear': monthYear,
    'baseSalary': baseSalary,
    'totalWorkingDays': totalWorkingDays,
    'presentDays': presentDays,
    'deductions': deductions,
    'netPay': netPay,
    'generatedAt': generatedAt,
  };

  factory SalaryRecord.fromJson(Map<String, dynamic> json) {
    return SalaryRecord(
      uid: json['uid'] as String,
      staffName: json['staffName'] as String,
      monthYear: json['monthYear'] as String,
      baseSalary: (json['baseSalary'] as num).toDouble(),
      totalWorkingDays: json['totalWorkingDays'] as int,
      presentDays: json['presentDays'] as int,
      deductions: (json['deductions'] as num?)?.toDouble() ?? 0.0,
      netPay: (json['netPay'] as num).toDouble(),
      generatedAt: (json['generatedAt'] as Timestamp).toDate(),
    );
  }
}
