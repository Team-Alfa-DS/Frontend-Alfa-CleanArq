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
  Future<Result<List<Course>>> getCourseFiltered(
      {required String category,
      required String filter,
      required String trainer}) async {
    await _addAuthorizationHeader();
    final response = await _apiRequestManager.request(
      '/course/many/?Filter=$filter&Trainer=$trainer&Category=$category',
      'GET',
      (data) => (data['courses'] as List)
          .map((courseData) => CourseMapper.fromJson(courseData))
          .toList(),
    );
    return response;
  }

  @override
  Future<Result<List<Course>>> getCourseMany(
      {required int page, required int perPage}) async {
    print('Inicio de Many');
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    print('Mitad de Many');
    try {
      final response = await _apiRequestManager.request(
        '/course/many',
        'GET',
        (data) {
          print('Data received in getCourseMany: $data');
          List<Course> courses = (data['courses'] as List)
              .map((courseData) => CourseMapper.fromJson(courseData))
              .toList();
          print('List of courses in getCourseMany:');
          courses.forEach((course) => print(course));
          return courses;
        },
      );
      print('Response in getCourseMany:');
      print(response);
      return response;
    } catch (e) {
      print('Error in getCourseMany: $e');
      throw e;
    }
  }

  @override
  Future<Result<Course>> getSingleCourse({required String id}) async {
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    final response = await _apiRequestManager
        .request<Course>('/course/one/${id}', 'GET', (data) {
      print('Data received in getSingleCourse: $data');
      return CourseMapper.fromJson(data);
    });
    if (response.hasValue()) {
      final course = response.value!;
      print('Course in getSingleCourse:');
      print(course);
    }
    return response;
  }
}
