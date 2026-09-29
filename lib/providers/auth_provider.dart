import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

final firebaseAuthProvider =
    Provider<firebase_auth.FirebaseAuth>((ref) => firebase_auth.FirebaseAuth.instance);

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateChangesProvider = StreamProvider<firebase_auth.User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class AuthNotifier extends StateNotifier<User?> {
  final AuthService _authService;
  StreamSubscription<User?>? _subscription;

  AuthNotifier(this._authService) : super(null) {
    _subscription = _authService.userChanges.listen((user) {
      state = user;
    });
  }

  Future<User?> login(String email, String password) {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  Future<User?> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    required String role,
    double? salary,
  }) {
    final normalizedRole =
        role.toLowerCase() == 'admin' ? 'admin' : 'employee';
    return _authService.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      phone: phone,
      role: normalizedRole,
      salary: salary,
    );
  }

  Future<void> logout() async {
    await _authService.signOut();
    state = null;
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email.trim());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  ref.keepAlive();
  return AuthNotifier(ref.watch(authServiceProvider));
});
