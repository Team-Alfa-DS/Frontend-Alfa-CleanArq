import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

abstract class ProgressRepository {
  Future<Result<List<Progress>>> getProgressCourse(
    int page,
    int perPage,
  );
  Future<Result<Progress>> getProgressProfile(
      CreateProgressProfileRequest profileRequest);
  Future<Result<Progress>> postProgress(
    PostProgress postProgress,
    int courseId,
    int lessonId,
  );
  Future<Result<Progress>> getSingleCourseProgress(
      SingleCourseProgress singleCourse, String idCourse);
  Future<Result<Progress>> getTrendingProgress(
      TrendingProgress trendingProgress, String idCourse, String courseTitle);
}