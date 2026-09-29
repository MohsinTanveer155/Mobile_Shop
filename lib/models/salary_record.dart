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
    final rawGeneratedAt = json['generatedAt'];
    final DateTime generatedAt;

    if (rawGeneratedAt is Timestamp) {
      generatedAt = rawGeneratedAt.toDate();
    } else if (rawGeneratedAt is DateTime) {
      generatedAt = rawGeneratedAt;
    } else if (rawGeneratedAt is String) {
      generatedAt = DateTime.tryParse(rawGeneratedAt) ?? DateTime.now();
    } else {
      generatedAt = DateTime.now();
    }

    return SalaryRecord(
      uid: json['uid'] is String ? json['uid'] as String : '',
      staffName: json['staffName'] is String ? json['staffName'] as String : 'Unknown staff',
      monthYear: json['monthYear'] is String ? json['monthYear'] as String : 'Unknown',
      baseSalary: (json['baseSalary'] is num ? json['baseSalary'] as num : 0).toDouble(),
      totalWorkingDays: json['totalWorkingDays'] is int ? json['totalWorkingDays'] as int : 0,
      presentDays: json['presentDays'] is int ? json['presentDays'] as int : 0,
      deductions: (json['deductions'] is num ? json['deductions'] as num : 0).toDouble(),
      netPay: (json['netPay'] is num ? json['netPay'] as num : 0).toDouble(),
      generatedAt: generatedAt,
    );
  }
}
