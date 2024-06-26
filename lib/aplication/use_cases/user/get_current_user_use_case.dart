import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/user_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/user_repository.dart';

class GetCurrentUserUseCaseInput extends IUseCaseInput {}

class GetCurrentUserUseCase
    extends IUseCase<GetCurrentUserUseCaseInput, CurrentUserResponse> {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  GetCurrentUserUseCase(
      {required this.userRepository, required this.localStorage});

  @override
  Future<Result<CurrentUserResponse>> execute(
      GetCurrentUserUseCaseInput params) async {
    final token = await localStorage.getAuthorizationToken();
    final result = await userRepository.getCurrentUser(
      CurrentUserRequest(token: token),
    );

    if (result.hasValue()) {
      final user = result.value!;
      print('User ID: ${user.id}');
      print('User Name: ${user.name}');
      print('User Email: ${user.email}');
      print('User Phone: ${user.phone}');
      print('User Image: ${user.image}');
    }

    return result;
  }
}
