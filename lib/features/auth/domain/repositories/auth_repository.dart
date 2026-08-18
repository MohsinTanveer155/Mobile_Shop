import '../entities/user_entity.dart';

/// Auth contract — Domain only. Implemented in Data layer.
abstract class AuthRepository {
  Stream<UserEntity?> watchAuthState();

  bool get isLoggedIn;

  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    required String role,
    double? salary,
  });

  Future<void> logout();

  Future<void> sendPasswordResetEmail(String email);
}
