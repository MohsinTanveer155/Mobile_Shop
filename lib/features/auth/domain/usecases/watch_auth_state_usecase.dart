import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Streams auth session changes. Not a [UseCase] Future — dedicated watcher.
class WatchAuthStateUseCase {
  final AuthRepository repository;

  const WatchAuthStateUseCase(this.repository);

  Stream<UserEntity?> call() => repository.watchAuthState();

  bool get isLoggedIn => repository.isLoggedIn;
}
