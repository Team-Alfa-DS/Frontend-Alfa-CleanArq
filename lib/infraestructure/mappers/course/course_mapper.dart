import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/lesson/lesson_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/trainer/trainer_mapper.dart';

class CourseMapper {
  static Course fromJson(Map<String, dynamic> json) {
    try {
      return Course(
        id: json['id'] as String,
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        category: json['category'] as String? ?? '',
        image: json['image'] as String? ?? '',
        trainer: TrainerMapper.fromJson(json['trainer']),
        level: json['level'] as String? ?? '',
        durationWeeks: json['durationWeeks'] as int? ?? 0,
        durationMinutes: json['durationMinutes'] as int? ?? 0,
        tags: List<String>.from(json['tags']),
        date: DateTime.parse(json['date']),
        lessons: (json['lessons'] as List)
            .map((lessonData) => LessonMapper.fromJson(lessonData))
            .toList(),
      );
    } catch (e) {
      print('Error in CourseMapper.fromJson: $e');
      throw e;
    }
  }

  static Map<String, dynamic> toJson(Course course) {
    return {
      'id': course.id,
      'title': course.title,
      'description': course.description,
      'category': course.category,
      'image': course.image,
      'trainer': TrainerMapper.toJson(course.trainer),
      'level': course.level,
      'durationWeeks': course.durationWeeks,
      'durationMinutes': course.durationMinutes,
      'tags': course.tags,
      'date': course.date?.toIso8601String(),
      'lessons':
          course.lessons.map((lesson) => LessonMapper.toJson(lesson)).toList(),
    };
  }
}
