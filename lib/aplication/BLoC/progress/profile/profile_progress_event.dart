part of 'profile_progress_bloc.dart';

abstract class ProfileProgressEvent extends Equatable {
  const ProfileProgressEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileProgress extends ProfileProgressEvent {}
