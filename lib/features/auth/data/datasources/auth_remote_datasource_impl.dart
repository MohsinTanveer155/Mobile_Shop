import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  static const String _usersCollection = 'users';

  @override
  Stream<UserModel?> watchAuthState() {
    return _auth.authStateChanges().asyncMap(_profileForFirebaseUser);
  }

  @override
  bool get isLoggedIn => _auth.currentUser != null;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final current = credential.user ?? _auth.currentUser;
      if (current == null) {
        throw const AuthException(
          'No authenticated user found after sign-in.',
          code: 'user-not-found',
        );
      }
      final profile = await _profileForFirebaseUser(current);
      if (profile == null) {
        throw const AuthException(
          'Unable to load user profile after login. Please try again.',
          code: 'user-profile-not-found',
        );
      }
      return profile;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_mapAuthCode(e), code: e.code);
    } on AuthException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? e.code, code: e.code);
    } catch (e) {
      if (e.runtimeType.toString() == 'ProgressEvent') {
        throw const NetworkException();
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    required String role,
    double? salary,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = cred.user!.uid;
      final formattedRole =
          role.toLowerCase() == 'admin' ? 'admin' : 'employee';

      final model = UserModel(
        id: uid,
        name: name,
        role: formattedRole,
        isAdmin: formattedRole == 'admin',
        email: email,
        phone: phone,
        salary: salary,
      );

      await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .set(model.toFirestore(includeServerTimestamps: true));

      final profile = await _profileForFirebaseUser(cred.user);
      if (profile == null) {
        return model;
      }
      return profile;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_mapAuthCode(e), code: e.code);
    } on AuthException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? e.code, code: e.code);
    } catch (e) {
      if (e.runtimeType.toString() == 'ProgressEvent') {
        throw const NetworkException();
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_mapAuthCode(e), code: e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_mapAuthCode(e), code: e.code);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? e.code, code: e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<UserModel?> _profileForFirebaseUser(
    firebase_auth.User? firebaseUser,
  ) async {
    if (firebaseUser == null) return null;

    try {
      final docRef = _firestore.collection(_usersCollection).doc(firebaseUser.uid);
      final doc = await docRef.get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson({'id': firebaseUser.uid, ...doc.data()!});
      }

      final fallbackName = firebaseUser.displayName?.trim().isNotEmpty == true
          ? firebaseUser.displayName!.trim()
          : (firebaseUser.email?.split('@').first ?? 'User');

      await docRef.set({
        'name': fallbackName,
        'email': firebaseUser.email,
        'phone': null,
        'role': 'employee',
        'isAdmin': false,
        'salary': null,
        'createdAt': FieldValue.serverTimestamp(),
        'joiningDate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      final refreshed = await docRef.get();
      if (refreshed.exists && refreshed.data() != null) {
        return UserModel.fromJson({'id': firebaseUser.uid, ...refreshed.data()!});
      }

      return UserModel(
        id: firebaseUser.uid,
        name: fallbackName,
        role: 'employee',
        isAdmin: false,
        email: firebaseUser.email,
      );
    } catch (e) {
      debugPrint('AuthRemoteDataSource profile sync failed: $e');
      return UserModel(
        id: firebaseUser.uid,
        name: firebaseUser.displayName?.trim().isNotEmpty == true
            ? firebaseUser.displayName!.trim()
            : (firebaseUser.email?.split('@').first ?? 'User'),
        role: 'employee',
        isAdmin: false,
        email: firebaseUser.email,
      );
    }
  }

  String _mapAuthCode(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'email-already-in-use':
        return 'Email already in use.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network problem. Please check your internet connection.';
      case 'user-profile-not-found':
        return 'Unable to load user profile. Please try again.';
      default:
        return e.message?.isNotEmpty == true
            ? e.message!
            : 'Authentication failed. Please try again.';
    }
  }
}
