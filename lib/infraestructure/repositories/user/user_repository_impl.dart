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
      '/auth/register',
      'POST',
      (data) {
        data['id'] = data['token'];
        data['role'] = 'regular';
        return UserMapper.fromJson(data);
      },
      body: {
        'email': loginRequest.email,
        'password': loginRequest.password,
      },
    );

    if (response.hasValue()) {
      _apiRequestManager.setHeaders(
          'Authorization', 'Bearer ${response.value!.id}');
    }

    return response;
  }

  @override
  Future<Result<User>> registerUser(RegisterUserRequest registerRequest) async {
    final response = await _apiRequestManager.request(
      '/auth/register',
      'POST',
      (data) {
        data['id'] = data['token'];
        data['role'] = 'regular';
        return UserMapper.fromJson(data);
      },
      body: {
        'email': registerRequest.email,
        'password': registerRequest.password,
        'name': registerRequest.name,
        'phone': registerRequest.phone,
      },
    );

    if (response.hasValue()) {
      _apiRequestManager.setHeaders(
          'Authorization', 'Bearer ${response.value!.id}');
    }

    return response;
  }
}
