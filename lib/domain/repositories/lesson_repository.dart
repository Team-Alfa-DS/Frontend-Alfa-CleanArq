import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/lesson_interfaces.dart';

abstract class LessonRepository {
  Future<Result<Lesson>> createLesson(CreateLessonRequest createRequest);
  Future<Result<List<Lesson>>> getLessons({
    required int courseId,
    required int page,
    required int perPage,
  });
}
