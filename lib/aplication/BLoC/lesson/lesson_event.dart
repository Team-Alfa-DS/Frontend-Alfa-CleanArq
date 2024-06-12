import 'package:equatable/equatable.dart';

abstract class LessonDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadLessonDetailEvent extends LessonDetailEvent {
  final String courseId;
  final String lessonId;
  final int page;
  final int perPage;

  LoadLessonDetailEvent({
    required this.courseId,
    required this.lessonId,
    required this.page,
    required this.perPage,
  });

  @override
  List<Object?> get props => [courseId, page, perPage];
}
