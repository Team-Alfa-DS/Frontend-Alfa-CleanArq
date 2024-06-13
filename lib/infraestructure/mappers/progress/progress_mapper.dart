import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';

class ProgressProfileMapper {
  static Progress fromJson(Map<String, dynamic> json) {
    return Progress(
      user: json['user'],
      percent: json['percent'],
      time: json['time'],
    );
  }

  static Map<String, dynamic> toJson(Progress profile) {
    return {
      'user': profile.user,
      'percent': profile.percent,
      'time': profile.time,
    };
  }
}

class ProgressCourseMapper {
  static Progress fromJson(Map<String, dynamic> json) {
    return Progress(
      user: json['user'],
      courses: (json['courses'] as List)
          .map((courseData) => CourseMapper.fromJson(courseData))
          .toList(),
      percent: json['percent'],
      time: json['time'],
      markAsComplete: json['markAsComplete'],
    );
  }

  static Map<String, dynamic> toJson(Progress course) {
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
