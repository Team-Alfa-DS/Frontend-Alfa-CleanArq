import 'package:alpha_gymnastic_center/common/result.dart';

abstract class IUseCaseInput {}

abstract class IUseCase<I extends IUseCaseInput, O> {
  Future<Result<O>> execute(I params);
}
