import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';

class UpdateUserUseCaseInput extends IUseCaseInput {
  final String token;
  final String? email;
  final String? name;
  final String? password;
  final String? phone;
  final String? image;

  UpdateUserUseCaseInput({
    required this.token,
    this.email,
    this.name,
    this.password,
    this.phone,
    this.image,
  });
}

class UpdateUserUseCase extends IUseCase<UpdateUserUseCaseInput, void> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  UpdateUserUseCase({required this.userRepository, required this.localStorage});

  @override
  Future<Result<void>> execute(UpdateUserUseCaseInput params) async {
    UpdateUserRequest updateUserRequest = UpdateUserRequest(
      email: params.email,
      name: params.name,
      password: params.password,
      phone: params.phone,
      image: params.image,
    );

    final result =
        await userRepository.updateUser(params.token, updateUserRequest);
    if (result.hasValue()) {
      // Si es necesario, guarda algún dato en localStorage o realiza alguna acción adicional
    }
    return result;
  }
}
