import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/di/injection_container.dart';
import '../core/usecase/usecase.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/logout_usecase.dart';
import '../features/auth/domain/usecases/reset_password_usecase.dart';
import '../features/auth/domain/usecases/signup_usecase.dart';
import '../features/auth/domain/usecases/watch_auth_state_usecase.dart';
import '../features/auth/presentation/mappers/user_mapper.dart';
import '../models/user.dart';

/// Compatibility bridge — existing screens keep using [authProvider] / [User].
/// Internally delegates to Clean Architecture use cases from GetIt.
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(
    loginUseCase: sl<LoginUseCase>(),
    signupUseCase: sl<SignupUseCase>(),
    logoutUseCase: sl<LogoutUseCase>(),
    resetPasswordUseCase: sl<ResetPasswordUseCase>(),
    watchAuthStateUseCase: sl<WatchAuthStateUseCase>(),
  );
});

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier({
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
        super(null) {
    _subscription = _watchAuthStateUseCase().listen((entity) {
      state = entity?.toAppUser();
    });
  }

  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final LogoutUseCase _logoutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final WatchAuthStateUseCase _watchAuthStateUseCase;
  StreamSubscription? _subscription;

  Future<String?> login(String email, String password) async {
    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );
    return result.fold(
      onFailure: (failure) {
        debugPrint('AuthNotifier login: ${failure.message}');
        return failure.message;
      },
      onSuccess: (user) {
        state = user.toAppUser();
        return null;
      },
    );
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    String role = 'staff',
    double? salary,
  }) async {
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
    result.fold(
      onFailure: (failure) {
        throw Exception(failure.message);
      },
      onSuccess: (user) {
        state = user.toAppUser();
      },
    );
  }

  Future<void> logout() async {
    final result = await _logoutUseCase(const NoParams());
    result.fold(
      onFailure: (failure) {
        debugPrint('AuthNotifier logout: ${failure.message}');
        throw Exception(failure.message);
      },
      onSuccess: (_) {
        state = null;
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
  bool get isAdmin => state?.isAdmin ?? false;
  bool get isStaff => state?.isStaff ?? false;
  bool get isEmployee => state?.isEmployee ?? false;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
