import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

abstract class VideoRepository {
  Future<Result<Video>> getVideoDetails(String courseId, String lessonId);
  Future<Result<void>> saveVideoProgress(
      PostProgressRequest postProgressRequest);
}
