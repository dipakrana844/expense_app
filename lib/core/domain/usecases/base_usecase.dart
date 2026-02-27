import '../../error/failures.dart';

typedef UseCaseResult<T> = Future<(T?, Failure?)>;

abstract class BaseUseCase<T, Params> {
  UseCaseResult<T> call(Params params);
}

abstract class BaseStreamUseCase<T, Params> {
  Stream<T> call(Params params);
}

class NoParams {
  const NoParams();
}
