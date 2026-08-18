import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel?> watchAuthState();

  bool get isLoggedIn;

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> signup({
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
