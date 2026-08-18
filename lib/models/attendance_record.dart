import 'package:cloud_firestore/cloud_firestore.dart';

enum AttendanceStatus { present, absent, halfDay }

class AttendanceRecord {
  final String uid;
  final String date; // YYYY-MM-DD
  final DateTime? checkIn;
  final DateTime? checkOut;
  final AttendanceStatus status;
  final Duration? totalHours;

  const AttendanceRecord({
    required this.uid,
    required this.date,
    this.checkIn,
    this.checkOut,
    this.status = AttendanceStatus.present,
    this.totalHours,
  });

  bool get isCheckedIn => checkIn != null && checkOut == null;
  bool get isCheckedOut => checkIn != null && checkOut != null;
  bool get hasAttendance => checkIn != null;

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'date': date,
    'checkIn': checkIn,
    'checkOut': checkOut,
    'status': status.toString().split('.').last,
    'totalHours': totalHours?.inMinutes,
  };

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    DateTime? checkIn;
    if (json['checkIn'] is Timestamp) {
      checkIn = (json['checkIn'] as Timestamp).toDate();
    }

    DateTime? checkOut;
    if (json['checkOut'] is Timestamp) {
      checkOut = (json['checkOut'] as Timestamp).toDate();
    }

    final statusStr = json['status'] as String? ?? 'present';
    final status = AttendanceStatus.values.firstWhere(
      (e) => e.toString().split('.').last == statusStr,
      orElse: () => AttendanceStatus.present,
    );

    final totalMinutes = json['totalHours'] as int?;
    final totalHours = totalMinutes != null ? Duration(minutes: totalMinutes) : null;

    return AttendanceRecord(
      uid: json['uid'] as String,
      date: json['date'] as String,
      checkIn: checkIn,
      checkOut: checkOut,
      status: status,
      totalHours: totalHours,
    );
  }
}
