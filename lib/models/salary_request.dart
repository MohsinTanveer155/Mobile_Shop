import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum SalaryRequestStatus { pending, approved, rejected }

class SalaryRequest {
  final String id;
  final String staffId;
  final String staffName;
  final double amount;
  final SalaryRequestStatus status;
  final String? reason;
  final DateTime requestDate; // When the request was made
  final String? adminRemark;
  final DateTime createdAt;
  final DateTime? updatedAt;

  SalaryRequest({
    String? id,
    required this.staffId,
    required this.staffName,
    required this.amount,
    this.status = SalaryRequestStatus.pending,
    this.reason,
    required this.requestDate,
    this.adminRemark,
    required this.createdAt,
    this.updatedAt,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'staffId': staffId,
      'staffName': staffName,
      'amount': amount,
      'status': status.name,
      'reason': reason,
      'requestDate': Timestamp.fromDate(requestDate),
      'adminRemark': adminRemark,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory SalaryRequest.fromJson(Map<String, dynamic> json) {
    final requestDate = _dateTimeFromJson(json['requestDate']) ??
        _dateTimeFromJson(json['createdAt']) ??
        DateTime.now();

    return SalaryRequest(
      id: _stringFromJson(json['id']),
      staffId: _stringFromJson(json['staffId']),
      staffName: _stringFromJson(json['staffName'], fallback: 'Unknown staff'),
      amount: _numberFromJson(json['amount']),
      status: _statusFromJson(json['status']),
      reason: _nullableStringFromJson(json['reason']),
      requestDate: requestDate,
      adminRemark: _nullableStringFromJson(json['adminRemark']),
      createdAt: _dateTimeFromJson(json['createdAt']) ?? requestDate,
      updatedAt: _dateTimeFromJson(json['updatedAt']),
    );
  }

  static String _stringFromJson(dynamic value, {String fallback = ''}) {
    return value is String ? value : fallback;
  }

  static String? _nullableStringFromJson(dynamic value) {
    return value is String ? value : null;
  }

  static double _numberFromJson(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _dateTimeFromJson(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static SalaryRequestStatus _statusFromJson(dynamic value) {
    return SalaryRequestStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => SalaryRequestStatus.pending,
    );
  }
}
