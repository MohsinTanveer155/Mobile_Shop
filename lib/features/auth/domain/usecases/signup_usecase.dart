import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignupParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final String? phone;
  final String role;
  final double? salary;

  const SignupParams({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
    this.role = 'staff',
    this.salary,
  });

  @override
  List<Object?> get props => [email, password, name, phone, role, salary];
}

class SignupUseCase implements UseCase<UserEntity, SignupParams> {
  final AuthRepository repository;

  const SignupUseCase(this.repository);

  @override
  Future<Result<UserEntity>> call(SignupParams params) async {
    final email = params.email.trim().toLowerCase();
    final name = params.name.trim();
    final password = params.password;

    if (name.isEmpty) {
      return const ResultFailure(ValidationFailure('Full name is required.'));
    }
    if (email.isEmpty || !_isValidEmail(email)) {
      return const ResultFailure(
        ValidationFailure('Please enter a valid email address.'),
      );
    }
    if (password.length < 6) {
      return const ResultFailure(
        ValidationFailure('Password must be at least 6 characters.'),
      );
    }

    try {
      final user = await repository.signup(
        email: email,
        password: password,
        name: name,
        phone: params.phone?.trim().isEmpty == true ? null : params.phone?.trim(),
        role: params.role,
        salary: params.salary,
      );
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
