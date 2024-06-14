part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterUserResponse registerUserResponse;

  const RegisterSuccess({required this.registerUserResponse});

  @override
  List<Object> get props => [registerUserResponse];
}

class RegisterFailure extends RegisterState {
  final Failure failure;

  const RegisterFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
