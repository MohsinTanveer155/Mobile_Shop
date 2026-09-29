import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/staff_service.dart';
import '../models/user.dart';

final staffServiceProvider = Provider<StaffService>((ref) => StaffService());

final staffProfileProvider = FutureProvider.family<User?, String>((ref, uid) {
  final service = ref.watch(staffServiceProvider);
  return service.getStaffProfile(uid);
});

final allStaffProvider = StreamProvider<List<User>>((ref) {
  final service = ref.watch(staffServiceProvider);
  return service.getAllStaff();
});

final staffByRoleProvider = StreamProvider.family<List<User>, String>((ref, role) {
  final service = ref.watch(staffServiceProvider);
  return service.getStaffByRole(role);
});

class StaffNotifier extends StateNotifier<void> {
  final StaffService _service;

  StaffNotifier(this._service) : super(null);

  Future<void> updateProfile(String uid, Map<String, dynamic> updates) async {
    await _service.updateStaffProfile(uid, updates);
  }

  Future<User> createStaff({
    required String name,
    required String email,
    required String password,
    String? phone,
    double? salary,
  }) {
    return _service.createStaff(
      name: name,
      email: email,
      password: password,
      phone: phone,
      salary: salary,
    );
  }

  Future<void> deleteProfile(String uid) {
    return _service.deleteStaffProfile(uid);
  }
}

final staffNotifierProvider = StateNotifierProvider<StaffNotifier, void>((ref) {
  final service = ref.watch(staffServiceProvider);
  return StaffNotifier(service);
});

/// Alias used by admin staff management screens.
final staffProvider = staffNotifierProvider;

