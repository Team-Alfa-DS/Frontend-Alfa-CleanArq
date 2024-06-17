import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/course_interfaces.dart';

abstract class CourseRepository {
  Future<Result<Course>> createCourse(CreateCourseRequest createRequest);

  Future<Result<List<Course>>> getCourseMany({
    required int page,
    required int perpage,
  });

  Future<Result<List<Course>>> getCourseFiltered(
      {required String filter,
      required String category,
      required String trainer});

  Future<Result<Course>> getSingleCourse({required String id});
}
