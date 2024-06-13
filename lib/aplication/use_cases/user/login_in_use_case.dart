import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';

class LogInUseCaseInput extends IUseCaseInput {
  final String email;
  final String password;

  LogInUseCaseInput({required this.email, required this.password});
}

class LogInUseCase extends IUseCase<LogInUseCaseInput, User> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  LogInUseCase({required this.userRepository, required this.localStorage});

  @override
  Future<Result<User>> execute(LogInUseCaseInput params) async {
    final result = await userRepository.logInUser(
      LoginUserRequest(email: params.email, password: params.password),
    );
    print("Result usecase");
    print(result.value);
    if (result.hasValue()) {
      final user = result.value!;
      print('User ID: ${user.id}');
      print('User Token : ${user.token}');
      await localStorage.setKeyValue('appToken', user.token!);
      // await localStorage.setKeyValue('role', user.type.toString());
      print(
          'Token saved in local storage: ${await localStorage.getAuthorizationToken()}');
    }
    return result;
  }
}
