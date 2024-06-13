import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';

class Course {
  String? id;
  String title;
  String description;
  String category;
  String image;
  Trainer trainer;
  String level;
  int durationWeeks;
  int durationMinutes;
  List<String> tags;
  DateTime? date;
  List<Lesson> lessons;
  int? percent;

  Course({
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