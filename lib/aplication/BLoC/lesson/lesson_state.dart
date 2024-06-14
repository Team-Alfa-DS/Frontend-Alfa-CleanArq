import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';

abstract class LessonDetailState {
  const LessonDetailState();
}

class LessonDetailInitial extends LessonDetailState {
  const LessonDetailInitial();
}

class LessonDetailLoading extends LessonDetailState {
  const LessonDetailLoading();
}

class LessonDetailLoaded extends LessonDetailState {
  final List<Lesson> lessons;

  const LessonDetailLoaded({required this.lessons});

  List<Object?> get props => [lessons];
}

class LessonDetailError extends LessonDetailState {
  final Failure failure;

  const LessonDetailError({required this.failure});
}
