import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadVideoDetailEvent extends VideoEvent {
  final String courseId;
  final String lessonId;
  final String videoUrl;

  LoadVideoDetailEvent({
    required this.courseId,
    required this.lessonId,
    required this.videoUrl,
  });

  @override
  List<Object?> get props => [courseId, lessonId, videoUrl];
}

class SaveVideoProgressEvent extends VideoEvent {
  final String courseId;
  final String lessonId;
  final int time;

  SaveVideoProgressEvent({
    required this.courseId,
    required this.lessonId,
    required this.time,
  });

  @override
  List<Object?> get props => [courseId, lessonId, time];
}
