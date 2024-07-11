part of 'videos_bloc.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideosState {}

class VideoLoading extends VideosState {}

class VideoLoaded extends VideosState {
  final List<Course> courses;

  const VideoLoaded({required this.courses});

  @override
  List<Object> get props => [courses];
}

class VideoError extends VideosState {
  final String message;

  const VideoError({required this.message});

  @override
  List<Object> get props => [message];
}
