import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';

class ForgotPasswordUseCaseInput extends IUseCaseInput {
  final String email;

  ForgotPasswordUseCaseInput({required this.email});
}

class ForgotPasswordUseCase extends IUseCase<ForgotPasswordUseCaseInput, void> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  ForgotPasswordUseCase(
      {required this.userRepository, required this.localStorage});

  @override
  Future<Result<ForgetPasswordResponse>> execute(
      ForgotPasswordUseCaseInput params) async {
    ForgetPasswordRequest forgetPasswordRequest =
        ForgetPasswordRequest(email: params.email);
    final result = await userRepository.forgetPassword(forgetPasswordRequest);
    print("resultado: xd");
    print(result.hasValue());
    print("resultado: xd");
    print(result.value);
    if (result.hasValue()) {}
    return result;
  }
}
