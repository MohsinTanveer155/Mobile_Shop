import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  @override
  Future<Result<UserEntity>> call(LoginParams params) async {
    final email = params.email.trim().toLowerCase();
    final password = params.password;

    if (email.isEmpty || password.isEmpty) {
      return const ResultFailure(
        ValidationFailure('Please enter both email and password.'),
      );
    }
    if (!_isValidEmail(email)) {
      return const ResultFailure(
        ValidationFailure('Please enter a valid email address.'),
      );
    }

    try {
      final user = await repository.login(email: email, password: password);
      return Success(user);
    } on Failure catch (f) {
      return ResultFailure(f);
    } catch (e) {
      return ResultFailure(UnexpectedFailure(e.toString()));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }
}
