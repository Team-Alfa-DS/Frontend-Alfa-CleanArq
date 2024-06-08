import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/course_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class CourseRepositoryImpl extends CourseRepository {
  final IApiRequestManager _apiRequestManager;

  CourseRepositoryImpl({required IApiRequestManager apiRequestManager})
      : _apiRequestManager = apiRequestManager;

  @override
  Future<Result<Course>> createCourse(CreateCourseRequest createRequest) async {
    final response = await _apiRequestManager.request(
      '/courses',
      'POST',
      (data) => CourseMapper.fromJson(data),
      body: CourseMapper.toJson(
        Course(
          id: '',
          title: createRequest.title,
          description: createRequest.description,
          category: createRequest.category,
          image: createRequest.image,
          trainer: createRequest.trainer,
          level: createRequest.level,
          durationWeeks: createRequest.durationWeeks,
          durationMinutes: createRequest.durationMinutes,
          tags: createRequest.tags,
          date: createRequest.date,
          lessons: createRequest.lessons,
        ),
      ),
    );

    return response;
  }

  @override
  Future<Result<List<Course>>> getCourse(
      {required int page, required int perPage}) async {
    final response = await _apiRequestManager.request(
      '/courses?page=$page&per_page=$perPage',
      'GET',
      (data) => (data as List)
          .map((courseData) => CourseMapper.fromJson(courseData))
          .toList(),
    );

    return response;
  }
}
