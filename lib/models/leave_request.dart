import 'package:cloud_firestore/cloud_firestore.dart';

enum LeaveType { sick, casual, annual, emergency }
enum LeaveStatus { pending, approved, rejected }

class LeaveRequest {
  final String id;
  final String uid;
  final String staffName;
  final LeaveType type;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final LeaveStatus status;
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? adminRemark;
  final int totalDays;

  const LeaveRequest({
    required this.id,
    required this.uid,
    required this.staffName,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.status = LeaveStatus.pending,
    this.approvedBy,
    this.approvedAt,
    this.adminRemark,
    required this.totalDays,
  });

  bool get isPending => status == LeaveStatus.pending;
  bool get isApproved => status == LeaveStatus.approved;
  bool get isRejected => status == LeaveStatus.rejected;

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'staffName': staffName,
    'type': type.toString().split('.').last,
    'startDate': startDate,
    'endDate': endDate,
    'reason': reason,
    'status': status.toString().split('.').last,
    'approvedBy': approvedBy,
    'approvedAt': approvedAt,
    'adminRemark': adminRemark,
    'totalDays': totalDays,
  };

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String? ?? 'casual';
    final type = LeaveType.values.firstWhere(
      (e) => e.toString().split('.').last == typeStr,
      orElse: () => LeaveType.casual,
    );

    final statusStr = json['status'] as String? ?? 'pending';
    final status = LeaveStatus.values.firstWhere(
      (e) => e.toString().split('.').last == statusStr,
      orElse: () => LeaveStatus.pending,
    );

    DateTime startDate;
    if (json['startDate'] is Timestamp) {
      startDate = (json['startDate'] as Timestamp).toDate();
    } else {
      startDate = DateTime.parse(json['startDate'] as String);
    }

    DateTime endDate;
    if (json['endDate'] is Timestamp) {
      endDate = (json['endDate'] as Timestamp).toDate();
    } else {
      endDate = DateTime.parse(json['endDate'] as String);
    }

    DateTime? approvedAt;
    if (json['approvedAt'] != null) {
      if (json['approvedAt'] is Timestamp) {
        approvedAt = (json['approvedAt'] as Timestamp).toDate();
      } else {
        approvedAt = DateTime.parse(json['approvedAt'] as String);
      }
    }

    final totalDays = json['totalDays'] as int;

    return LeaveRequest(
      id: json['id'] as String,
      uid: json['uid'] as String,
      staffName: json['staffName'] as String,
      type: type,
      startDate: startDate,
      endDate: endDate,
      reason: json['reason'] as String,
      status: status,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: approvedAt,
      adminRemark: json['adminRemark'] as String?,
      totalDays: totalDays,
    );
  }
}
