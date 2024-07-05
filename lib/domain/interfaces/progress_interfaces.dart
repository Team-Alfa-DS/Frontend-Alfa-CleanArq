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

class MarkEndProgressRequest {
  final String courseId;
  final bool markAsCompleted;
  final String lessonId;
  final int? time;

  MarkEndProgressRequest({
    required this.courseId,
    required this.markAsCompleted,
    required this.lessonId,
    this.time,
  });
}

class ProgressOneResponse {
  final double percent;
  final List<LessonProgress> lessons;

  ProgressOneResponse({
    required this.percent,
    required this.lessons,
  });
}

class LessonProgress {
  final String lessonId;
  final int? time;
  final double percent;

  LessonProgress({
    required this.lessonId,
    this.time,
    required this.percent,
  });
}

class TrendingProgressResponse {
  final double percent;
  final String courseTitle;
  final String courseId;
  final DateTime lastTime;

  TrendingProgressResponse({
    required this.percent,
    required this.courseTitle,
    required this.courseId,
    required this.lastTime,
  });
}

class ProfileProgressResponse {
  final double percent;
  final int time;

  ProfileProgressResponse({
    required this.percent,
    required this.time,
  });
}

class CoursesProgressResponse {
  final List<CourseProgress> courses;

  CoursesProgressResponse({required this.courses});
}

class CourseProgress {
  final String id;
  final String title;
  final String image;
  final DateTime date;
  final String category;
  final String trainer;
  final double percent;

  CourseProgress({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.category,
    required this.trainer,
    required this.percent,
  });
}