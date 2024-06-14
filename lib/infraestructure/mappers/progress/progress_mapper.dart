import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/lesson/lesson_mapper.dart';

class ProgressProfileMapper {
  static Progress fromJson(Map<String, dynamic> json) {
    return Progress(
      percent: json['percent'],
      time: json['time'],
    );
  }

  static Map<String, dynamic> toJson(Progress profile) {
    return {
      'percent': profile.percent,
      'time': profile.time,
    };
  }
}

class ProgressCourseMapper {
  static Progress fromJson(Map<String, dynamic> json) {
    return Progress(
      courses: (json['courses'] as List)
          .map((courseData) => CourseMapper.fromJson(courseData))
          .toList(),
      percent: json['percent'],
    );
  }

  static Map<String, dynamic> toJson(Progress course) {
    return {
      'courses': course.courses
          ?.map((courses) => CourseMapper.toJson(courses))
          .toList(),
      'percent': course.percent,
    };
  }
}

class ProgressPostMapper {
  static Progress fromJson(Map<String, dynamic> json) {
    return Progress(
      courseId: json['courseId'],
      markAsComplete: json['markAsComplete'],
      lessonId: json['lessonId'],
      time: json['time'],
    );
  }

  static Map<String, dynamic> toJson(Progress post) {
    return {
      'courseId': post.courseId,
      'markAsComplete': post.markAsComplete,
      'lesson': post.lessonId,
      'time': post.time,
    };
  }
}

class ProgressSingleCourseMapper {
  static Progress fromJson(Map<String, dynamic> json) {
    return Progress(
      percent: json['percent'],
      lesson: (json['lesson'] as List)
          .map((lessonData) => LessonMapper.fromJson(lessonData))
          .toList(),
    );
  }

  static Map<String, dynamic> toJson(Progress single) {
    return {
      'percent': single.percent,
      'lesson':
          single.lesson?.map((lesson) => LessonMapper.toJson(lesson)).toList(),
    };
  }
}

class ProgressTrendingMapper {
  static Progress fromJson(Map<String, dynamic> json) {
    return Progress(
      percent: json['percent'],
      courseId: json['courseId'],
      courseTitle: json['courseTitle'],
      lastTime: json['lastTime'],
    );
  }

  static Map<String, dynamic> toJson(Progress trending) {
    return {
      'percent': trending.percent,
      'courseId': trending.courseId,
      'courseTitle': trending.courseTitle,
      'lastTime': trending.lastTime,
    };
  }
}