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

  const UpdateUserSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object> get props => [name, email, password, phone];
}