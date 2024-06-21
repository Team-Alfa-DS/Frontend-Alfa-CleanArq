import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

abstract class ProgressRepository {
  Future<Result<void>> markEndProgress(MarkEndProgressRequest request);
  Future<Result<ProgressOneResponse>> getProgressOne(String courseId);
  Future<Result<List<TrendingProgressResponse>>> getTrendingProgress();
  Future<Result<ProfileProgressResponse>> getProfileProgress();
  Future<Result<CoursesProgressResponse>> getCoursesProgress(
      int page, int perPage);
}
