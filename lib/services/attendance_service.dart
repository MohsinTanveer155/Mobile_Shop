import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/attendance_record.dart';
import 'firestore_error_handler.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Mark check-in (prevent duplicate for today)
  Future<bool> checkIn(String uid) async {
    return runFirestoreOperation(() async {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final docRef = _firestore.collection('attendance').doc(uid).collection('days').doc(today);

      final doc = await docRef.get();
      if (doc.exists && doc.data()!['checkIn'] != null) {
        return false; // Already checked in today
      }

      await docRef.set({
        'uid': uid,
        'date': today,
        'checkIn': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return true;
    }, context: 'AttendanceService.checkIn');
  }

  /// Mark check-out
  Future<bool> checkOut(String uid) async {
    return runFirestoreOperation(() async {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final docRef = _firestore.collection('attendance').doc(uid).collection('days').doc(today);

      final doc = await docRef.get();
      if (!doc.exists || doc.data()!['checkIn'] == null || doc.data()!['checkOut'] != null) {
        return false;
      }

      await docRef.update({
        'checkOut': FieldValue.serverTimestamp(),
      });

      return true;
    }, context: 'AttendanceService.checkOut');
  }

  /// Get today's status
  Stream<AttendanceRecord?> getTodayAttendance(String uid) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return _firestore
        .collection('attendance')
        .doc(uid)
        .collection('days')
        .doc(today)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return AttendanceRecord.fromJson({
        'uid': uid,
        'date': today,
        ...doc.data()!,
      });
    });
  }

  /// Get attendance history (last 30 days)
  Stream<List<AttendanceRecord>> getAttendanceHistory(String uid, {int days = 30}) {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: days));
    final startDateString = DateFormat('yyyy-MM-dd').format(startDate);

    return _firestore
        .collection('attendance')
        .doc(uid)
        .collection('days')
        .where('date', isGreaterThanOrEqualTo: startDateString)
        .orderBy('date', descending: true)
        .limit(30)
        .snapshots()
        .handleError((error, stackTrace) {
          logFirestoreError(error, stackTrace as StackTrace?, context: 'AttendanceService.getAttendanceHistory');
        })
        .map((snapshot) => snapshot.docs
            .map((doc) => AttendanceRecord.fromJson({
                  'uid': uid,
                  'date': doc['date'],
                  ...doc.data(),
                }))
            .toList());
  }

  /// Get present days count for month
  Future<int> getPresentDays(String uid, String monthYear) async {
    return runFirestoreOperation(() async {
      final querySnapshot = await _firestore
          .collection('attendance')
          .doc(uid)
          .collection('days')
          .where('date', isGreaterThanOrEqualTo: '$monthYear-01')
          .get();

      return querySnapshot.docs
          .where((doc) => doc.data()['checkIn'] != null)
          .length;
    }, context: 'AttendanceService.getPresentDays');
  }
}
