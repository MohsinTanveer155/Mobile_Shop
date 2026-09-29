import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user.dart';

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

  Future<User> createStaff({
    required String name,
    required String email,
    required String password,
    String? phone,
    double? salary,
  }) async {
    try {
      final auth = firebase_auth.FirebaseAuth.instance;
      final credential = await auth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );
      final uid = credential.user!.uid;

      await _firestore.collection(_usersCollection).doc(uid).set({
        'name': name.trim(),
        'email': email.trim().toLowerCase(),
        'phone': phone?.trim().isEmpty == true ? null : phone?.trim(),
        'role': 'employee',
        'isAdmin': false,
        'salary': salary,
        'createdAt': FieldValue.serverTimestamp(),
        'joiningDate': FieldValue.serverTimestamp(),
      });

      return User(
        id: uid,
        name: name.trim(),
        role: UserRole.employee,
        isAdmin: false,
        email: email.trim().toLowerCase(),
        phone: phone?.trim(),
        salary: salary,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteStaffProfile(String uid) {
    return _firestore.collection(_usersCollection).doc(uid).delete();
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
