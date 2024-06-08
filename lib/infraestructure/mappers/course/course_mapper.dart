import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/lesson/lesson_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/trainer/trainer_mapper.dart';

class CourseMapper {
  static Course fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      trainer: TrainerMapper.fromJson(json['trainer']),
      level: CourseLevel.values[json['level']],
      durationWeeks: json['durationWeeks'],
      durationMinutes: json['durationMinutes'],
      tags: List<String>.from(json['tags']),
      date: DateTime.parse(json['date']),
      lessons: (json['lessons'] as List)
          .map((lessonData) => LessonMapper.fromJson(lessonData))
          .toList(),
    );
  }

  static Map<String, dynamic> toJson(Course course) {
    return {
      'id': course.id,
      'title': course.title,
      'description': course.description,
      'category': course.category,
      'image': course.image,
      'trainer': TrainerMapper.toJson(course.trainer),
      'level': course.level.index,
      'durationWeeks': course.durationWeeks,
      'durationMinutes': course.durationMinutes,
      'tags': course.tags,
      'date': course.date.toIso8601String(),
      'lessons':
          course.lessons.map((lesson) => LessonMapper.toJson(lesson)).toList(),
    };
  }
}
