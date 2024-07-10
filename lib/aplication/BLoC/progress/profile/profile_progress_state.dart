part of 'profile_progress_bloc.dart';

abstract class ProfileProgressState extends Equatable {
  const ProfileProgressState();

  @override
  List<Object> get props => [];
}

class ProfileProgressInitial extends ProfileProgressState {}

class ProfileProgressLoading extends ProfileProgressState {}

class ProfileProgressLoaded extends ProfileProgressState {
  final double percent;
  final int time;

  ProfileProgressLoaded({required double percent, required this.time})
      : percent = double.parse((percent / 100).toStringAsFixed(2));

  @override
  List<Object> get props => [percent, time];
}

class ProfileProgressError extends ProfileProgressState {
  final String message;

  const ProfileProgressError({required this.message});

  @override
  List<Object> get props => [message];
}
