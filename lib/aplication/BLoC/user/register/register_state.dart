part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;

  const RegisterSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterFailure extends RegisterState {
  final Failure failure;

  const RegisterFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
