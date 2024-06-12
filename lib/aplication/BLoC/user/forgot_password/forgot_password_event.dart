part of "forgot_password_bloc.dart";

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}
