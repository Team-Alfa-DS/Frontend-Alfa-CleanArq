import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/course_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/course_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/create_course_mapper.dart';
import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';


class CourseRepositoryImpl extends CourseRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  CourseRepositoryImpl({
    required IApiRequestManager apiRequestManager,
    required LocalStorage localStorage,
  })  : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<Course>> createCourse(CreateCourseRequest createRequest) async {
    await _addAuthorizationHeader();
    final response = await _apiRequestManager.request(
      '/courses',
      'POST',
          (data) => CourseMapper.fromJson(data),
      body: CreateCourseRequestMapper.toJson(createRequest),
    );

    return response;
  }

  @override
  Future<Result<List<Course>>> getCourseMany({
    required int page,
    required int perPage,
    required String filter,
  }) async {
    await _addAuthorizationHeader();
    try {
      final response = await _apiRequestManager.request(
        '/course/many?filter=$filter&page=$page&perpage=$perPage',
        'GET',
            (data) {
          List<Course> courses = (data['courses'] as List)
              .map((courseData) => CourseMapper.fromJson(courseData))
              .toList();
          return courses;
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Result<List<Course>>> getCourseFiltered({
    required String filter,
    required String category,
    required String trainer,
    required int page,
    required int perPage,
  }) async {
    await _addAuthorizationHeader();
    final response = await _apiRequestManager.request(
      '/course/many?filter=$filter&trainer=$trainer&category=$category&page=$page&perpage=$perPage',
      'GET',
          (data) {
        List<Course> courses = (data['courses'] as List)
            .map((courseData) => CourseMapper.fromJson(courseData))
            .toList();
        return courses;
      },
    );
    return response;
  }

  @override
  Future<Result<Course>> getSingleCourse({required String id}) async {
    await _addAuthorizationHeader();
    final response = await _apiRequestManager
        .request<Course>('/course/one/$id', 'GET', (data) {
      return CourseMapper.fromJson(data);
    });
    return response;
  }
}
