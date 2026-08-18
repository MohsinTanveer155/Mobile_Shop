import 'user.dart';
import 'attendance_record.dart';
import 'salary_record.dart';

class StaffProfile extends User {
  final List<AttendanceRecord> recentAttendance;
  final List<SalaryRecord> salaryHistory;
  final double? currentSalary;

  const StaffProfile({
    required super.id,
    required super.name,
    required super.role,
    required super.isAdmin,
    super.email,
    super.phone,
    super.joiningDate,
    this.currentSalary,
    this.recentAttendance = const [],
    this.salaryHistory = const [],
  });

  factory StaffProfile.fromUser(User user, {
    List<AttendanceRecord> recentAttendance = const [],
    List<SalaryRecord> salaryHistory = const [],
    double? currentSalary,
  }) {
    return StaffProfile(
      id: user.id,
      name: user.name,
      role: user.role,
      isAdmin: user.isAdmin,
      email: user.email,
      phone: user.phone,
      joiningDate: user.joiningDate,
      currentSalary: currentSalary,
      recentAttendance: recentAttendance,
      salaryHistory: salaryHistory,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'recentAttendance': recentAttendance.map((a) => a.toJson()).toList(),
      'salaryHistory': salaryHistory.map((s) => s.toJson()).toList(),
    };
  }
}
