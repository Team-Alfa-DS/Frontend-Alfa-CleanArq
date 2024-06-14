import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/user/user_mapper.dart';
import '../../../common/result.dart';

class UserRepositoryImpl extends UserRepository {
  final IApiRequestManager _apiRequestManager;

  UserRepositoryImpl({required IApiRequestManager apiRequestManager})
      : _apiRequestManager = apiRequestManager;

  @override
  Future<Result<User>> logInUser(LoginUserRequest loginRequest) async {
    final response = await _apiRequestManager.request<User>(
      '/auth/login',
      'POST',
      (data) {
        return UserMapper.fromJson(data);
      },
      body: {
        'email': loginRequest.email,
        'password': loginRequest.password,
      },
    );

    print("response");
    print(response.value);
    final user = response.value;
    if (user != null) {
      print('User ID: ${user.id}');
      print('User Name: ${user.name}');
      print('User Email: ${user.email}');
      print('User Phone: ${user.phone}');
      print('User Type: ${user.type}');
      print('User Token : ${user.token}');
    } else {
      print('No user data received');
    }

    if (response.hasValue()) {
      _apiRequestManager.setHeaders(
          'Authorization', 'Bearer ${response.value!.token}');
    }

    return response;
  }

  @override
  Future<Result<RegisterUserResponse>> registerUser(
      RegisterUserRequest registerRequest) async {
    final response = await _apiRequestManager.request<RegisterUserResponse>(
      '/auth/register',
      'POST',
      (data) {
        return RegisterUserResponse(id: data['id']);
      },
      body: {
        'email': registerRequest.email,
        'password': registerRequest.password,
        'name': registerRequest.name,
        'phone': registerRequest.phone,
        'type': 'CLIENT', //registerRequest.type ?? 'CLIENT',
      },
    );

    return response;
  }

  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    final response = await _apiRequestManager.request<ForgetPasswordResponse>(
      '/auth/forget/password',
      'POST',
      (data) {
        print("la data");
        print(data);
        return ForgetPasswordResponse(date: data["date"]);
      },
      body: {
        'email': forgetPasswordRequest.email,
      },
    );

    return response;
  }

  @override
  Future<Result<void>> validateCode(
      ValidateCodeRequest validateCodeRequest) async {
    final response = await _apiRequestManager.request<void>(
      '/auth/code/validate',
      'POST',
      (data) {},
      body: {
        'email': validateCodeRequest.email,
        'code': validateCodeRequest.code,
      },
    );

    return response;
  }

  @override
  Future<Result<void>> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    final response = await _apiRequestManager.request<void>(
      '/auth/change/password',
      'PUT',
      (data) {},
      body: {
        'email': changePasswordRequest.email,
        'code': changePasswordRequest.code,
        'password': changePasswordRequest.password,
      },
    );

    return response;
  }

  @override
  Future<Result<User>> getCurrentUser(String token) async {
    _apiRequestManager.setHeaders('token', token);
    final response = await _apiRequestManager.request<User>(
      '/auth/current',
      'GET',
      (data) {
        return UserMapper.fromJson(data);
      },
    );

    return response;
  }

  @override
  Future<Result<void>> updateUser(
      String token, UpdateUserRequest updateUserRequest) async {
    _apiRequestManager.setHeaders('token', token);
    final response = await _apiRequestManager.request<void>(
      '/user/update',
      'PUT',
      (data) {},
      body: {
        if (updateUserRequest.email != null) 'email': updateUserRequest.email,
        if (updateUserRequest.name != null) 'name': updateUserRequest.name,
        if (updateUserRequest.password != null)
          'password': updateUserRequest.password,
        if (updateUserRequest.phone != null) 'phone': updateUserRequest.phone,
        if (updateUserRequest.image != null) 'image': updateUserRequest.image,
      },
    );

    return response;
  }
}
