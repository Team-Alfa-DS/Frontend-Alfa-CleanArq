part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final Video video;
  final int currentTime;

  const VideoLoaded({required this.video, required this.currentTime});

  @override
  List<Object?> get props => [video, currentTime];
}

class VideoProgressSaved extends VideoState {}

class VideoError extends VideoState {
  final String message;

  const VideoError({required this.message});

  @override
  List<Object?> get props => [message];
}
