import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';

abstract class VideoRepository {
  Future<Result<Video>> getVideoDetails(String courseId, String lessonId);
  Future<Result<void>> saveVideoProgress(
      String courseId, String lessonId, int time,
      {bool markAsCompleted = false});
}
