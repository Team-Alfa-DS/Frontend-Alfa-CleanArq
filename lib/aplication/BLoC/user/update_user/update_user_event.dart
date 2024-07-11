part of 'update_user_bloc.dart';

class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserSubmitted extends UpdateUserEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String image;

  const UpdateUserSubmitted(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.image});

  @override
  List<Object> get props => [name, email, password, phone, image];
}
