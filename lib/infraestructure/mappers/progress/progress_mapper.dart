import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';

class ProgressProfileMapper {
  static ProgressProfile fromJson(Map<String, dynamic> json) {
    return ProgressProfile(
      user: json['user'],
      percent: json['percent'],
      time: json['time'],
    );
  }

  static Map<String, dynamic> toJson(ProgressProfile profile) {
    return {
      'user': profile.user,
      'percent': profile.percent,
      'time': profile.time,
    };
  }
}

class ProgressCourseMapper {
  static ProgressCourse fromJson(Map<String, dynamic> json) {
    return ProgressCourse(
      user: json['user'],
      courses: (json['courses'] as List)
          .map((courseData) => CourseMapper.fromJson(courseData))
          .toList(),
      percent: json['percent'],
      time: json['time'],
      markAsComplete: json['markAsComplete'],
    );
  }

  static Map<String, dynamic> toJson(ProgressCourse course) {
    return {
      'user': course.user,
      'courses': course.courses
          ?.map((courses) => CourseMapper.toJson(courses))
          .toList(),
      'percent': course.percent,
      'time': course.time,
      'markAsComplete': course.markAsComplete,
    };
  }
}
