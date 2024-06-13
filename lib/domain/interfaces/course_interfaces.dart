import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';

class CreateCourseRequest {
  final String title;
  final String description;
  final String category;
  final String image;
  final Trainer trainer;
  final String level;
  final int durationWeeks;
  final int durationMinutes;
  final List<String> tags;
  final DateTime date;
  final List<Lesson> lessons;

  CreateCourseRequest({
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.trainer,
    required this.level,
    required this.durationWeeks,
    required this.durationMinutes,
    required this.tags,
    required this.date,
    required this.lessons,
  });

}
