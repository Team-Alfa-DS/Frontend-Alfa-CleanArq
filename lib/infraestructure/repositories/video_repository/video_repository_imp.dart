import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';
import 'package:alpha_gymnastic_center/domain/repositories/video_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';

class VideoRepositoryImpl implements VideoRepository {
  final IApiRequestManager _apiRequestManager;

  VideoRepositoryImpl({required IApiRequestManager apiRequestManager})
      : _apiRequestManager = apiRequestManager;

  @override
  Future<Result<Video>> getVideoDetails(
      String courseId, String lessonId) async {
    final response = await _apiRequestManager.request<Video>(
      '/video/details',
      'GET',
      (data) {
        return Video(
            id: data["id"], url: data["url"], idLesson: data["id_lesson"]);
      },
      queryParameters: {
        'courseId': courseId,
        'lessonId': lessonId,
      },
    );

    return response;
  }

  @override
  Future<Result<void>> saveVideoProgress(
      String courseId, String lessonId, int time,
      {bool markAsCompleted = false}) async {
    final response = await _apiRequestManager.request<void>(
      '/progress/mark/end',
      'POST',
      (data) {},
      body: {
        'courseId': courseId,
        'lessonId': lessonId,
        'time': time,
        'markAsCompleted': markAsCompleted,
      },
    );

    return response;
  }
}
