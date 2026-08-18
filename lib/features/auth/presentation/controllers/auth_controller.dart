import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/watch_auth_state_usecase.dart';
import 'auth_state.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    loginUseCase: sl<LoginUseCase>(),
    signupUseCase: sl<SignupUseCase>(),
    logoutUseCase: sl<LogoutUseCase>(),
    resetPasswordUseCase: sl<ResetPasswordUseCase>(),
    watchAuthStateUseCase: sl<WatchAuthStateUseCase>(),
  );
});

/// Presentation controller — talks ONLY to use cases (never datasources/models).
class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
    required LogoutUseCase logoutUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required WatchAuthStateUseCase watchAuthStateUseCase,
  })  : _loginUseCase = loginUseCase,
        _signupUseCase = signupUseCase,
        _logoutUseCase = logoutUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _watchAuthStateUseCase = watchAuthStateUseCase,
        super(const AuthInitial()) {
    _subscription = _watchAuthStateUseCase().listen(_onAuthStream);
  }

  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final LogoutUseCase _logoutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final WatchAuthStateUseCase _watchAuthStateUseCase;
  StreamSubscription<UserEntity?>? _subscription;

  UserEntity? get currentUser {
    final s = state;
    if (s is AuthAuthenticated) return s.user;
    return null;
  }

  void _onAuthStream(UserEntity? user) {
    if (user == null) {
      state = const AuthUnauthenticated();
    } else {
      state = AuthAuthenticated(user);
    }
  }

  Future<String?> login(String email, String password) async {
    state = const AuthLoading();
    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );
    return result.fold(
      onFailure: (failure) {
        debugPrint('Login failed: ${failure.code} ${failure.message}');
        state = AuthError(failure.message);
        return failure.message;
      },
      onSuccess: (user) {
        state = AuthAuthenticated(user);
        return null;
      },
    );
  }

  Future<String?> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    String role = 'staff',
    double? salary,
  }) async {
    state = const AuthLoading();
    final result = await _signupUseCase(
      SignupParams(
        email: email,
        password: password,
        name: name,
        phone: phone,
        role: role,
        salary: salary,
      ),
    );
    return result.fold(
      onFailure: (failure) {
        debugPrint('Signup failed: ${failure.code} ${failure.message}');
        state = AuthError(failure.message);
        return failure.message;
      },
      onSuccess: (user) {
        state = AuthAuthenticated(user);
        return null;
      },
    );
  }

  Future<void> logout() async {
    state = const AuthLoading();
    final result = await _logoutUseCase(const NoParams());
    result.fold(
      onFailure: (failure) {
        debugPrint('Logout failed: ${failure.message}');
        state = AuthError(failure.message);
      },
      onSuccess: (_) {
        state = const AuthUnauthenticated();
      },
    );
  }

  Future<String?> resetPassword(String email) async {
    final result = await _resetPasswordUseCase(ResetPasswordParams(email));
    return result.fold(
      onFailure: (failure) => failure.message,
      onSuccess: (_) => null,
    );
  }

  bool get isLoggedIn => _watchAuthStateUseCase.isLoggedIn;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
