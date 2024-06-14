import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';

class CreateProgressCourseRequestMapper {
  static Map<String, dynamic> toJson(
      CreateProgressCourseRequest courseRequest) {
    return {
      'user': courseRequest.user,
      'courses': courseRequest.courses
          ?.map((courses) => CourseMapper.toJson(courses))
          .toList(),
      'percent': courseRequest.percent,
      'time': courseRequest.time,
      'markAsComplete': courseRequest.markAsComplete,
    };
  }
}
