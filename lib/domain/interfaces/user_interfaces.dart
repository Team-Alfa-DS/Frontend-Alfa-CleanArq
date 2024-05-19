class LoginUserRequest {
  final String email;
  final String password;

  LoginUserRequest({
    required this.email,
    required this.password,
  });
}

class RegisterUserRequest {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterUserRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}
