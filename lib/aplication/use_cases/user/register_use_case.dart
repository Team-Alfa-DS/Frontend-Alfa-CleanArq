import 'package:alpha_gymnastic_center/common/use_case.dart';

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

// class RegisterUseCase extends IUseCase<RegisterUseCaseInput,User>{
//   final UserRepository userRepository;
//   final LocalStorage localStorage;

//   RegisterUseCase({
//     required this.userRepository, required this.localStorage
//   });

//   @override
//   Future<Result<User>> execute(RegisterUseCaseInput params) {
//     // RegisterUserRequest registerRequest = RegisterUserRequest(email: params.email,name: params.email,password: params.password,phone: params.phone );
//     // result = await userRepository.registerUser(registerRequest);
    
//     // return result
//   }

// }
