import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';
import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class RegisterUseCaseInput extends IUseCaseInput {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterUseCaseInput(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone});
}

class RegisterUseCase
    extends IUseCase<RegisterUseCaseInput, RegisterUserResponse> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  RegisterUseCase({required this.userRepository, required this.localStorage});

  @override
  Future<Result<RegisterUserResponse>> execute(
      RegisterUseCaseInput params) async {
    RegisterUserRequest registerRequest = RegisterUserRequest(
        email: params.email,
        name: params.name,
        password: params.password,
        phone: params.phone);
    final result = await userRepository.registerUser(registerRequest);
    if (result.hasValue()) {}
    return result;
  }
}
