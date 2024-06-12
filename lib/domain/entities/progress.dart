import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class Progress {
  String id;
  User user;
  List<Course> courses;
  num percent;
  int time;
  bool markAsCompleted;

  Progress(
      {required this.id,
      required this.user,
      required this.courses,
      required this.percent,
      required this.time,
      required this.markAsCompleted});
}
