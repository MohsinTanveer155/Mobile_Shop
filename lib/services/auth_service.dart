import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as auth_user;

/// Firebase Authentication service with Firestore profile sync.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';

  /// Real-time user state stream (auth + profile)
  Stream<auth_user.User?> get userChanges {
    return _auth.authStateChanges().asyncMap(_userFromFirebaseUser);
  }

  /// Sync login
  bool get isLoggedIn => _auth.currentUser != null;

  // Alias for compatibility
  FirebaseAuth get firebaseAuthInstance => _auth;

  Future<auth_user.User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      debugPrint('AuthService: signInWithEmailAndPassword called with email="$email" normalized="$normalizedEmail"');
      await _auth.signInWithEmailAndPassword(email: normalizedEmail, password: password);
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No authenticated user found after sign-in.',
        );
      }

      final profile = await _userFromFirebaseUser(currentUser);
      if (profile == null) {
        throw FirebaseAuthException(
          code: 'user-profile-not-found',
          message: 'Unable to load or create your profile. Please try again.',
        );
      }
      return profile;
    } on FirebaseAuthException catch (e) {
      throw _firebaseErrorToString(e);
    } catch (e) {
      throw _exceptionToString(e);
    }
  }

  Future<auth_user.User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? phone,
    required String role,
    double? salary,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      debugPrint('AuthService: createUserWithEmailAndPassword called with email="$email" normalized="$normalizedEmail"');
      final cred = await _auth.createUserWithEmailAndPassword(email: normalizedEmail, password: password);
      final uid = cred.user!.uid;
      final formattedRole = role.toLowerCase() == 'admin' ? 'admin' : 'employee';

      // Create profile
      await _firestore.collection(_usersCollection).doc(uid).set({
        'name': name,
        'email': normalizedEmail,
        'phone': phone,
        'role': formattedRole,
        'isAdmin': formattedRole == 'admin',
        'salary': salary,
        'createdAt': FieldValue.serverTimestamp(),
        'joiningDate': FieldValue.serverTimestamp(),
      });

      final profile = await _userFromFirebaseUser(cred.user);
      return profile;
    } on FirebaseAuthException catch (e) {
      throw _firebaseErrorToString(e);
    } catch (e) {
      throw _exceptionToString(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _firebaseErrorToString(e);
    }
  }

  // Role-based permissions (use with current user)
  bool canManageProducts(auth_user.User? user) => user?.isAdmin ?? false;
  bool canViewReports(auth_user.User? user) => user?.isAdmin ?? false;
  bool canViewSales(auth_user.User? user) => true; // All staff can
  bool canManageSettings(auth_user.User? user) => user?.isAdmin ?? false;

  static auth_user.User createFallbackUser({
    required String uid,
    String? email,
    String? displayName,
  }) {
    final safeName = (displayName ?? email ?? 'User').toString().trim();
    final normalizedName = safeName.isNotEmpty ? safeName : 'User';
    final normalizedEmail = email?.trim().isNotEmpty == true ? email!.trim() : null;

    return auth_user.User(
      id: uid,
      name: normalizedName,
      role: auth_user.UserRole.employee,
      isAdmin: false,
      email: normalizedEmail,
    );
  }

  Future<auth_user.User?> _userFromFirebaseUser(User? firebaseUser) async {
    if (firebaseUser == null) return null;

    try {
      final docRef = _firestore.collection(_usersCollection).doc(firebaseUser.uid);
      final doc = await docRef.get();
      if (doc.exists) {
        return auth_user.User.fromJson({
          'id': firebaseUser.uid,
          ...doc.data()!,
        });
      }

      await docRef.set({
        'name': firebaseUser.displayName?.trim().isNotEmpty == true
            ? firebaseUser.displayName!.trim()
            : (firebaseUser.email?.split('@').first ?? 'User'),
        'email': firebaseUser.email,
        'phone': null,
        'role': 'employee',
        'isAdmin': false,
        'salary': null,
        'createdAt': FieldValue.serverTimestamp(),
        'joiningDate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      final refreshedDoc = await docRef.get();
      if (!refreshedDoc.exists) {
        return createFallbackUser(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          displayName: firebaseUser.displayName,
        );
      }

      return auth_user.User.fromJson({
        'id': firebaseUser.uid,
        ...refreshedDoc.data()!,
      });
    } catch (e) {
      return createFallbackUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
      );
    }
  }

  String _exceptionToString(Object e) {
    final exceptionType = e.runtimeType.toString();
    if (exceptionType == 'ProgressEvent') {
      return 'Network error while contacting Firebase. Please verify your internet connection and Firebase configuration.';
    }
    if (e is FirebaseException) {
      return 'Firebase error: ${e.message ?? e.code}';
    }
    return e.toString();
  }

  String _firebaseErrorToString(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'User disabled.';
      case 'email-already-in-use':
        return 'Email already in use.';
      case 'weak-password':
        return 'Password too weak.';
      case 'user-profile-not-found':
        return 'Logged in successfully, but Firestore profile is missing. Please contact support or try again.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}

