import 'package:equatable/equatable.dart';

/// Domain-level failure. Presentation maps this to user-facing messages.
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Network problem. Please check your connection.',
    String? code,
  ]) : super(code: code);
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Unable to complete the request. Please try again.',
    String? code,
  ]) : super(code: code);
}

class CacheFailure extends Failure {
  const CacheFailure([
    super.message = 'Unable to read local data.',
    String? code,
  ]) : super(code: code);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([
    super.message = 'Something went wrong. Please try again.',
    String? code,
  ]) : super(code: code);
}
