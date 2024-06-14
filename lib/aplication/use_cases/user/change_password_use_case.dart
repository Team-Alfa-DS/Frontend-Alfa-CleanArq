import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';

class ChangePasswordUseCaseInput extends IUseCaseInput {
  final String email;
  final int code;
  final String newPassword;

  ChangePasswordUseCaseInput({
    required this.email,
    required this.code,
    required this.newPassword,
  });
}

class ChangePasswordUseCase extends IUseCase<ChangePasswordUseCaseInput, void> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  ChangePasswordUseCase(
      {required this.userRepository, required this.localStorage});

  @override
  Future<Result<void>> execute(ChangePasswordUseCaseInput params) async {
    ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
      email: params.email,
      code: params.code,
      password: params.newPassword,
    );
    final result = await userRepository.changePassword(changePasswordRequest);
    if (result.hasValue()) {
      // Si es necesario, guarda algún dato en localStorage o realiza alguna acción adicional
    }
    return result;
  }
}
