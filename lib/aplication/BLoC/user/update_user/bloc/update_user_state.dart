part of 'update_user_bloc.dart';

sealed class UpdateUserState extends Equatable {
  const UpdateUserState();
  
  @override
  List<Object> get props => [];
}

final class UpdateUserInitial extends UpdateUserState {}
final class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final bool updateUserResponse;

  const UpdateUserSuccess({required this.updateUserResponse});

  @override
  List<Object> get props => [updateUserResponse];
}

class UpdateUserFailure extends UpdateUserState {
  final Failure failure;

  const UpdateUserFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}

