import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/course_interfaces.dart';

abstract class CourseRepository {
  Future<Result<Course>> createCourse(CreateCourseRequest createRequest);
  Future<Result<Course>> getCourse(String id);
}
