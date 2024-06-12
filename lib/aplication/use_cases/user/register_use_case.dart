import 'package:alpha_gymnastic_center/common/use_case.dart';

import '../../../common/result.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/interfaces/user_interfaces.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../localStorage/local_storage.dart';

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

class RegisterUseCase extends IUseCase<RegisterUseCaseInput, User> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  RegisterUseCase({required this.userRepository, required this.localStorage});

  @override
  Future<Result<User>> execute(RegisterUseCaseInput params) async {
    RegisterUserRequest registerRequest = RegisterUserRequest(
        email: params.email,
        name: params.email,
        password: params.password,
        phone: params.phone);
    final result = await userRepository.registerUser(registerRequest);
    if (result.hasValue()) {
      final user = result.value!;
      await localStorage.setKeyValue('appToken', user.id);
      await localStorage.setKeyValue('role', user.type.toString());
    }
    return result;
  }
}
