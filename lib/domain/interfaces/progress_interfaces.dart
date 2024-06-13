import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class CreateProgressProfileRequest {
  final User user;
  final num percent;
  final int time;

  CreateProgressProfileRequest(
      {required this.user, required this.percent, required this.time});
}

class CreateProgressCourseRequest {
  final User? user;
  final List<Course>? courses;
  final num? percent;
  final int? time;
  final bool? markAsComplete;

  CreateProgressCourseRequest(
      {required this.user,
      required this.courses,
      required this.percent,
      required this.time,
      required this.markAsComplete});
}
