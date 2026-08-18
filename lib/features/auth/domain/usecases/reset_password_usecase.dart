import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordParams extends Equatable {
  final String email;

  const ResetPasswordParams(this.email);

  @override
  List<Object?> get props => [email];
}

class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  final AuthRepository repository;

  const ResetPasswordUseCase(this.repository);

  @override
  Future<Result<void>> call(ResetPasswordParams params) async {
    final email = params.email.trim().toLowerCase();
    if (email.isEmpty || !_isValidEmail(email)) {
      return const ResultFailure(
        ValidationFailure('Please enter a valid email address.'),
      );
    }

    try {
      await repository.sendPasswordResetEmail(email);
      return const Success<void>(null);
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
