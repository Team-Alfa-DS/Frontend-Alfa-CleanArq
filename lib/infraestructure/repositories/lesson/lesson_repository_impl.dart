import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/lesson_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/lesson_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/lesson/lesson_mapper.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class LessonRepositoryImpl extends LessonRepository {
  final IApiRequestManager _apiRequestManager;

  LessonRepositoryImpl({required IApiRequestManager apiRequestManager})
      : _apiRequestManager = apiRequestManager;

  @override
  Future<Result<Lesson>> createLesson(CreateLessonRequest createRequest) async {
    final response = await _apiRequestManager.request(
      '/lessons',
      'POST',
      (data) => LessonMapper.fromJson(data),
      body: LessonMapper.toJson(
        Lesson(
          id: '',
          title: createRequest.title,
          content: createRequest.content,
          video: createRequest.video,
          image: createRequest.image,
        ),
      ),
    );

    return response;
  }

  @override
  Future<Result<List<Lesson>>> getLessons({
    required String courseId,
    required int page,
    required int perPage,
  }) async {
    final response = await _apiRequestManager.request(
      '/lessons?courseId=$courseId&page=$page&perPage=$perPage',
      'GET',
      (data) =>
          (data as List).map((item) => LessonMapper.fromJson(item)).toList(),
    );

    return response;
  }
}
