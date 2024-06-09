part of 'update_user_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserSubmitted extends UpdateUserEvent {
  final String token;
  final String? email;
  final String? name;
  final String? password;
  final String? phone;
  final String? image;

  const UpdateUserSubmitted({
    required this.token,
    this.email,
    this.name,
    this.password,
    this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [token, email, name, password, phone, image];
}
