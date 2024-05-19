import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';

abstract class UserRepository {
  //? Los de francis
  // Future<Result<User>> logInUser(String number, String notificationsToken);
  // Future<Result<User>> signUpUser(
  //     String number, String notificationsToken, String operator);
  //?---------------------------------------------------------------------------

  //! Los nuestros
  Future<Result<User>> logInUser(LoginUserRequest loginRequest);
  Future<Result<User>> registerUser(RegisterUserRequest registerRequest);
}
