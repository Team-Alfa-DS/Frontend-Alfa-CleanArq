import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class ProgressProfile {
  String id;
  User user;
  num percent;
  int time;

  ProgressProfile(
      {required this.id,
      required this.user,
      required this.percent,
      required this.time});
}

class ProgressCourse {
  String id;
  User user;
  List<Course> courses;
  num percent;
  int time;
  bool markAsComplete;

  ProgressCourse(
      {required this.id,
      required this.user,
      required this.courses,
      required this.percent,
      required this.time,
      required this.markAsComplete});
}
