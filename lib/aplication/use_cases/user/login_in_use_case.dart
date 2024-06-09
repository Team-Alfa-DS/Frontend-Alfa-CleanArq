// import 'package:alpha_gymnastic_center/application/services/foreground_notifications/local_notifications.dart';
// import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';
import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';

class LogInUseCaseInput extends IUseCaseInput {
  final String email;
  final String password;

  LogInUseCaseInput({required this.email, required this.password});
}

class LogInUseCase extends IUseCase<LogInUseCaseInput, User> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  // final LocalNotifications localNotifications;
  // final SocketClient socketClient;

  LogInUseCase({
    required this.userRepository,
    required this.localStorage,
    // required this.localNotifications,
    // required this.socketClient
  });

  @override
  Future<Result<User>> execute(LogInUseCaseInput params) async {
    // final notificationsToken = await localNotifications.getToken();
    // if () {
    LoginUserRequest loginRequest =
        LoginUserRequest(email: params.email, password: params.password);
    final result = await userRepository.logInUser(loginRequest);
    if (result.hasValue()) {
      final user = result.value!;
      await localStorage.setKeyValue('appToken', user.id);
      // await localStorage.setKeyValue(
      //     'notificationsToken', notificationsToken);
      await localStorage.setKeyValue('role', user.type.toString());

      // socketClient.updateAuth();
    }
    return result;
    // } else {
    //   return Result<User>(failure: const UnknownFailure());
    // }
  }
}
