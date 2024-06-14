import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class CreateProgressProfileRequest {
  final User user;
  final num percent;
  final int time;

  CreateProgressProfileRequest(
      {required this.user, required this.percent, required this.time});
}

class CreateProgressCourseRequest {
  final User user;
  final List<Course> courses;
  final num percent;
  final int time;
  final bool markAsComplete;

  CreateProgressCourseRequest(
      {required this.user,
      required this.courses,
      required this.percent,
      required this.time,
      required this.markAsComplete});
}

class PostProgress {
  final String courseId;
  final bool markAsComplete;
  final String lessonId;
  final int? time;

  PostProgress(
      {required this.courseId,
      required this.markAsComplete,
      required this.lessonId,
      this.time});
}

class SingleCourseProgress {
  final num percent;
  final List<Lesson> lesson;

  SingleCourseProgress({required this.percent, required this.lesson});
}

class TrendingProgress {
  final num percent;
  final String courseTitle;
  final String courseId;
  final String lastTime;

  TrendingProgress(
      {required this.percent,
      required this.courseTitle,
      required this.courseId,
      required this.lastTime});
}
