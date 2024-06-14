import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/progress_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/progress/progress_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/progress/progress_post_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/progress/progress_profile_mapper.dart';

class ProgressRepositoryImpl extends ProgressRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  ProgressRepositoryImpl({
    required IApiRequestManager apiRequestManager,
    required LocalStorage localStorage,
  })  : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<Progress>> postProgress(
    PostProgress postProgress,
    int courseId,
    int lessonId,
  ) async {
    final token = _addAuthorizationHeader();
    _apiRequestManager.setHeaders('token', token);
    final response = await _apiRequestManager.request(
      '/progress/mark/end',
      'POST',
      (data) => ProgressPostMapper.fromJson(data),
      body: PostProgressMapper.toJson(postProgress),
    );
    return response;
  }

  @override
  Future<Result<Progress>> getSingleCourseProgress(
      SingleCourseProgress singleCourse, String idCourse) async {
    final token = _addAuthorizationHeader();
    _apiRequestManager.setHeaders('token', token);
    final response = await _apiRequestManager.request(
      '/course/one/$idCourse',
      'GET',
      (data) {
        return ProgressSingleCourseMapper.fromJson(data);
      },
    );

    return response;
  }

  @override
  Future<Result<Progress>> getTrendingProgress(
      TrendingProgress trendingProgress,
      String idCourse,
      String courseTitle) async {
    final token = _addAuthorizationHeader();
    _apiRequestManager.setHeaders('token', token);
    final response = await _apiRequestManager.request(
      '/progress/trending',
      'GET',
      (data) {
        return ProgressTrendingMapper.fromJson(data);
      },
    );

    return response;
  }

  @override
  Future<Result<Progress>> getProgressProfile(
      CreateProgressProfileRequest profileRequest) async {
    final token = _addAuthorizationHeader();
    _apiRequestManager.setHeaders('token', token);
    final response = await _apiRequestManager.request(
      '/progress/profile',
      'GET',
      (data) => ProgressProfileMapper.fromJson(data),
      body: CreateProgressProfileRequestMapper.toJson(profileRequest),
    );
    return response;
  }

  @override
  Future<Result<List<Progress>>> getProgressCourse(
      int page, int perPage) async {
    final token = _addAuthorizationHeader();
    _apiRequestManager.setHeaders('token', token);
    final response = await _apiRequestManager.request(
      '/progress/courses/?page=$page&per_page=$perPage',
      'GET',
      (data) => (data as List)
          .map((courseData) => ProgressCourseMapper.fromJson(courseData))
          .toList(),
    );
    return response;
  }
}
