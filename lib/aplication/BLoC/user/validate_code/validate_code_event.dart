part of "validate_code_bloc.dart";

abstract class ValidateCodeEvent extends Equatable {
  const ValidateCodeEvent();

  @override
  List<Object> get props => [];
}

class ValidateCodeSubmitted extends ValidateCodeEvent {
  final String email;
  final int code;

  const ValidateCodeSubmitted({required this.email, required this.code});

  @override
  List<Object> get props => [email, code];
}
