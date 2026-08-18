import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
// import '../models/staff_profile.dart';

class StaffService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';

  /// Get all staff (admin only)
  Stream<List<User>> getAllStaff() {
    return _firestore
        .collection(_usersCollection)
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => User.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                }))
            .toList());
  }

  /// Get single staff profile
  Future<User?> getStaffProfile(String uid) async {
    final doc = await _firestore.collection(_usersCollection).doc(uid).get();
    if (doc.exists) {
      return User.fromJson({
        'id': doc.id,
        ...doc.data()!,
      });
    }
    return null;
  }

  /// Update staff profile (salary, phone, etc.)
  Future<void> updateStaffProfile(String uid, Map<String, dynamic> updates) {
    return _firestore.collection(_usersCollection).doc(uid).update(updates);
  }

  /// Get staff by role
  Stream<List<User>> getStaffByRole(String role) {
    return _firestore
        .collection(_usersCollection)
        .where('role', isEqualTo: role)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => User.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                }))
            .toList());
  }
}
