import 'result.dart';

abstract class IUseCaseInput {}

abstract class IUseCase<I extends IUseCaseInput, O> {
  Future<Result<O>> execute(I params);
}
