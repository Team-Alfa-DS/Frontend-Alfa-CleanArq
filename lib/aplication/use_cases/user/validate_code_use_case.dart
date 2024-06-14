import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';

class ValidateCodeUseCaseInput extends IUseCaseInput {
  final String email;
  final int code;

  ValidateCodeUseCaseInput({required this.email, required this.code});
}

class ValidateCodeUseCase extends IUseCase<ValidateCodeUseCaseInput, void> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  ValidateCodeUseCase(
      {required this.userRepository, required this.localStorage});

  @override
  Future<Result<void>> execute(ValidateCodeUseCaseInput params) async {
    ValidateCodeRequest validateCodeRequest =
        ValidateCodeRequest(email: params.email, code: params.code);
    final result = await userRepository.validateCode(validateCodeRequest);
    print("failure");
    print(result.failure);
    print("status code");
    print(result.statusCode);
    if (result.hasValue()) {
      //! pin pang
    }
    return result;
  }
}
