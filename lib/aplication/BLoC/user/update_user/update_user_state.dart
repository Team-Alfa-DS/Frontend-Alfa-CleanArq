part of 'update_user_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object?> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {}

class UpdateUserFailure extends UpdateUserState {
  final Failure failure;

  const UpdateUserFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
