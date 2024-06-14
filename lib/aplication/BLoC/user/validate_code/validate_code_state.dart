part of 'validate_code_bloc.dart';

abstract class ValidateCodeState extends Equatable {
  const ValidateCodeState();

  @override
  List<Object> get props => [];
}

class ValidateCodeInitial extends ValidateCodeState {}

class ValidateCodeLoading extends ValidateCodeState {}

class ValidateCodeSuccess extends ValidateCodeState {}

class ValidateCodeFailure extends ValidateCodeState {
  final Failure failure;

  const ValidateCodeFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
