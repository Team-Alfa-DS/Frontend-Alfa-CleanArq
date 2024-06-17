import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/lesson/lesson_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/trainer/trainer_mapper.dart';

import '../../../domain/entities/lesson.dart';
import '../../../domain/entities/trainer.dart';

class CourseMapper {
  static Course fromJson(Map<String, dynamic> json) {
    try {
      return Course(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        category: json['category'] as String? ?? '',
        image: json['image'] as String? ?? '',
        trainer: TrainerMapper.fromJson(json['trainer'] as Map<String, dynamic>),
        level: json['level'] as String? ?? '',
        durationWeeks: json['DurationWeeks'] != null ? json['DurationWeeks'] as int : 0,
        durationMinutes: json['DurationMinutes'] != null ? json['DurationMinutes'] as int : 0,
        tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
        date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
        lessons: (json['lessons'] as List<dynamic>?)
            ?.map((lessonData) => LessonMapper.fromJson(lessonData as Map<String, dynamic>))
            .toList() ??
            [],
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
