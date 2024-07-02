import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/lesson/lesson_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/trainer/trainer_mapper.dart';

class CourseMapper {
  static Course fromJson(Map<String, dynamic> json) {
    try {
      // Determine the type of 'trainer' field based on the structure of the JSON
      dynamic trainerData = json['trainer'];
      Trainer trainer;
      if (trainerData is String) {
        // Handle the case where 'trainer' is a string (endpoint /course/many)
        trainer = Trainer(id: '', name: trainerData);
      } else if (trainerData is Map<String, dynamic>) {
        // Handle the case where 'trainer' is a map (endpoint /course/one/:id)
        trainer = TrainerMapper.fromJson(trainerData);
      } else {
        // Default case: Initialize with empty values
        trainer = Trainer(id: '', name: '');
      }

      return Course(
        id: json['id'] as String?,
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        category: json['category'] as String? ?? '',
        image: json['image'] as String? ?? '',
        trainer: trainer,
        level: json['level'] != null ? json['level'].toString() : '',
        durationWeeks: json['durationWeeks'] != null
            ? (json['durationWeeks'] is double
                ? (json['durationWeeks'] as double).toInt()
                : json['durationWeeks'] as int)
            : 0,
        durationMinutes: json['durationMinutes'] != null
            ? (json['durationMinutes'] is double
                ? (json['durationMinutes'] as double).toInt()
                : json['durationMinutes'] as int)
            : 0,
        tags: json['tags'] != null
            ? List<String>.from(json['tags'] as List<dynamic>)
            : [],
        date: json['date'] != null
            ? DateTime.parse(json['date'] as String)
            : null,
        lessons: json['lessons'] != null
            ? (json['lessons'] as List)
                .map((lessonData) =>
                    LessonMapper.fromJson(lessonData as Map<String, dynamic>))
                .toList()
            : [],
      );
    } catch (e) {
      print('Error in CourseMapper.fromJson: $e');
      rethrow;
    }
  }

  static Course fromJsonPartial(Map<String, dynamic> json) {
    try {
      return Course(
        id: json['id'] as String?,
        title: json['title'] as String? ?? '',
        description: '',
        category: json['category'] as String? ?? '',
        image: json['image'] as String? ?? '',
        trainer: Trainer(id: '', name: ''), // Inicialización por defecto
        level: '',
        durationWeeks: 0,
        durationMinutes: 0,
        tags: [],
        date: json['date'] != null
            ? DateTime.parse(json['date'] as String)
            : null,
        lessons: [],
      );
    } catch (e) {
      print('Error in CourseMapper.fromJsonPartial: $e');
      rethrow;
    }
  }

  static Map<String, dynamic> toJson(Course course) {
    return {
      'id': course.id,
      'title': course.title,
      'description': course.description,
      'category': course.category,
      'image': course.image,
      'trainer': course.trainer
          .name, // Solo serializar el nombre del trainer para /course/many
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
