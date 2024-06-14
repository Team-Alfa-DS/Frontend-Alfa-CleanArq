import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/progress_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/progress/progress_course_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/progress/progress_mapper.dart';
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
  Future<Result<Progress>> getProgressProfile(
      CreateProgressProfileRequest profileRequest) async {
    await _addAuthorizationHeader();
    final response = await _apiRequestManager.request(
      '/progress/profile',
      'GET',
      (data) => ProgressProfileMapper.fromJson(data),
      body: CreateProgressProfileRequestMapper.toJson(profileRequest),
    );
    return response;
  }

  @override
  Future<Result<Progress>> getProgressCourse(
      CreateProgressCourseRequest courseRequest) async {
    await _addAuthorizationHeader();
    final response = await _apiRequestManager.request(
      '/progress/profile',
      'GET',
      (data) => ProgressCourseMapper.fromJson(data),
      body: CreateProgressCourseRequestMapper.toJson(courseRequest),
    );
    return response;
  }
}
