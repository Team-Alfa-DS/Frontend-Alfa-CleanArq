import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';
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
      PostProgressRequest postProgressRequest) async {
    print("PostPrgressRequest");
    print(postProgressRequest.courseId);
    print(postProgressRequest.lessonId);
    print(postProgressRequest.time);
    print(postProgressRequest.markAsComplete);
    print(postProgressRequest.totalTime);
    final response = await _apiRequestManager.request<void>(
      '/progress/mark/end',
      'POST',
      (data) {},
      body: {
        'courseId': postProgressRequest.courseId,
        'lessonId': postProgressRequest.lessonId,
        'time': postProgressRequest.time,
        'markAsCompleted': postProgressRequest.markAsComplete,
        'totalTime': postProgressRequest.totalTime
      },
    );

    print("Response");
    print(response);

    return response;
  }
}
