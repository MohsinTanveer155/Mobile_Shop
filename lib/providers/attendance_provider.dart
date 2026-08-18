import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance_record.dart';
import '../services/attendance_service.dart';

final attendanceServiceProvider = Provider<AttendanceService>((ref) => AttendanceService());

final todayAttendanceProvider = StreamProvider.family<AttendanceRecord?, String>((ref, uid) {
  final service = ref.watch(attendanceServiceProvider);
  return service.getTodayAttendance(uid);
});

final attendanceHistoryProvider = StreamProvider.family<List<AttendanceRecord>, String>((ref, uid) {
  final service = ref.watch(attendanceServiceProvider);
  return service.getAttendanceHistory(uid);
});

class AttendanceNotifier extends StateNotifier<void> {
  final AttendanceService _service;

  AttendanceNotifier(this._service) : super(null);

  Future<bool> checkIn(String uid) async {
    return await _service.checkIn(uid);
  }

  Future<bool> checkOut(String uid) async {
    return await _service.checkOut(uid);
  }
}

final attendanceNotifierProvider = StateNotifierProvider<AttendanceNotifier, void>((ref) {
  final service = ref.watch(attendanceServiceProvider);
  return AttendanceNotifier(service);
});
