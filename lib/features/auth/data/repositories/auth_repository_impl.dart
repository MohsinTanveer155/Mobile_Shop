import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<UserEntity?> watchAuthState() {
    return remoteDataSource.watchAuthState().map((model) => model?.toEntity());
  }

  @override
  bool get isLoggedIn => remoteDataSource.isLoggedIn;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return model.toEntity();
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    required String role,
    double? salary,
  }) async {
    try {
      final model = await remoteDataSource.signup(
        email: email,
        password: password,
        name: name,
        phone: phone,
        role: role,
        salary: salary,
      );
      return model.toEntity();
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
    } catch (e) {
      throw _mapException(e);
    }
  }

  Failure _mapException(Object e) {
    if (e is Failure) return e;
    if (e is AuthException) {
      return AuthFailure(e.message, code: e.code);
    }
    if (e is NetworkException) {
      return NetworkFailure(e.message);
    }
    if (e is ServerException) {
      return ServerFailure(e.message, e.code);
    }
    if (e is CacheException) {
      return CacheFailure(e.message);
    }
    return UnexpectedFailure(e.toString());
  }
}
