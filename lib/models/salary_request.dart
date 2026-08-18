import 'package:cloud_firestore/cloud_firestore.dart';

enum SalaryRequestStatus { pending, approved, rejected, paid }

class SalaryRequest {
  final String id;
  final String uid;
  final String employeeName;
  final DateTime requestDate;
  final double amount;
  final String reason;
  final SalaryRequestStatus status;
  final String? approvedBy;
  final DateTime? paymentDate;
  final String? adminRemark;

  const SalaryRequest({
    required this.id,
    required this.uid,
    required this.employeeName,
    required this.requestDate,
    required this.amount,
    required this.reason,
    this.status = SalaryRequestStatus.pending,
    this.approvedBy,
    this.paymentDate,
    this.adminRemark,
  });

  bool get isPending => status == SalaryRequestStatus.pending;
  bool get isApproved => status == SalaryRequestStatus.approved || status == SalaryRequestStatus.paid;
  bool get isRejected => status == SalaryRequestStatus.rejected;
  bool get isPaid => status == SalaryRequestStatus.paid;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'employeeName': employeeName,
        'requestDate': requestDate,
        'amount': amount,
        'reason': reason,
        'status': status.toString().split('.').last,
        'approvedBy': approvedBy,
        'paymentDate': paymentDate,
        'adminRemark': adminRemark,
      };

  factory SalaryRequest.fromJson(Map<String, dynamic> json) {
    final statusString = (json['status'] as String?)?.toLowerCase() ?? 'pending';
    final status = SalaryRequestStatus.values.firstWhere(
      (item) => item.toString().split('.').last == statusString,
      orElse: () => SalaryRequestStatus.pending,
    );

    DateTime parseDate(Object? value) {
      if (value == null) {
        return DateTime.now();
      }
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      return DateTime.tryParse(value.toString()) ?? DateTime.now();
    }

    final requestDate = parseDate(json['requestDate']);
    final paymentDate = json['paymentDate'] != null ? parseDate(json['paymentDate']) : null;

    return SalaryRequest(
      id: json['id'] as String,
      uid: json['uid'] as String,
      employeeName: json['employeeName'] as String,
      requestDate: requestDate,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String,
      status: status,
      approvedBy: json['approvedBy'] as String?,
      paymentDate: paymentDate,
      adminRemark: json['adminRemark'] as String?,
    );
  }
}
