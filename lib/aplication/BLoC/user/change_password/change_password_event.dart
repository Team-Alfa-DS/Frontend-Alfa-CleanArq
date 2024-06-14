part of "change_password_bloc.dart";

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final String email;
  final int code;
  final String newPassword;

  const ChangePasswordSubmitted({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  @override
  List<Object> get props => [email, code, newPassword];
}
