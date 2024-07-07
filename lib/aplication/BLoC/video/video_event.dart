part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideoDetailEvent extends VideoEvent {
  final String courseId;
  final String lessonId;

  const LoadVideoDetailEvent({required this.courseId, required this.lessonId});

  @override
  List<Object> get props => [courseId, lessonId];
}

class SaveVideoProgressEvent extends VideoEvent {
  final String courseId;
  final String lessonId;
  final int time;

  const SaveVideoProgressEvent({
    required this.courseId,
    required this.lessonId,
    required this.time,
  });

  @override
  List<Object> get props => [courseId, lessonId, time];
}
