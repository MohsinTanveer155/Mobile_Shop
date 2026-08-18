import '../../../../core/error/failures.dart';
import '../../../../core/usecase/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  const LogoutUseCase(this.repository);

  @override
  Future<Result<void>> call(NoParams params) async {
    try {
      await repository.logout();
      return const Success<void>(null);
    } on Failure catch (f) {
      return ResultFailure(f);
    } catch (e) {
      return ResultFailure(UnexpectedFailure(e.toString()));
    }
  }
}
