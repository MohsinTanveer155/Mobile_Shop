import 'result.dart';

/// Contract for every application use case.
abstract class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

/// Marker for use cases that need no input.
class NoParams {
  const NoParams();
}
