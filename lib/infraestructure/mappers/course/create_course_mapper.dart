import 'package:alpha_gymnastic_center/infraestructure/mappers/lesson/lesson_mapper.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/course_interfaces.dart';

class CreateCourseRequestMapper {
  static Map<String, dynamic> toJson(CreateCourseRequest createRequest) {
    return {
      'title': createRequest.title,
      'description': createRequest.description,
      'category': createRequest.category,
      'image': createRequest.image,
      'trainer': createRequest.trainer,
      'level': createRequest.level,
      'durationWeeks': createRequest.durationWeeks,
      'durationMinutes': createRequest.durationMinutes,
      'tags': createRequest.tags,
      'date': createRequest.date.toIso8601String(),
      'lessons': createRequest.lessons
          .map((lesson) => LessonMapper.toJson(lesson))
          .toList(),
    };
  }
}
