import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';

abstract class UserRepository {
  //! Los nuestros
  Future<Result<User>> logInUser(LoginUserRequest loginRequest);
  Future<Result<User>> registerUser(RegisterUserRequest registerRequest);

  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
  Future<Result<void>> validateCode(ValidateCodeRequest validateCodeRequest);
  Future<Result<void>> changePassword(
      ChangePasswordRequest changePasswordRequest);
  Future<Result<User>> getCurrentUser(String token);
  Future<Result<void>> updateUser(
      String token, UpdateUserRequest updateUserRequest);
}
