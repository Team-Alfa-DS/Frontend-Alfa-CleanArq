import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';

abstract class UserRepository {
  Future<Result<User>> logInUser(LoginUserRequest loginRequest);
  Future<Result<RegisterUserResponse>> registerUser(
      RegisterUserRequest registerRequest);
  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
  Future<Result<void>> validateCode(ValidateCodeRequest validateCodeRequest);
  Future<Result<void>> changePassword(
      ChangePasswordRequest changePasswordRequest);
  Future<Result<CurrentUserResponse>> getCurrentUser(
      CurrentUserRequest currentUserRequest);
  Future<Result<void>> updateUser(
      String token, UpdateUserRequest updateUserRequest);
}
