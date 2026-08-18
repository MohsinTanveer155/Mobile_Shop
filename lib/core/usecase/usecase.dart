import 'result.dart';

/// Contract for every application use case.
abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

/// Marker for use cases that need no input.
class NoParams {
  const NoParams();
}
