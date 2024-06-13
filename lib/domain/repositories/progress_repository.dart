import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

abstract class ProgressRepository {
  Future<Result<ProgressCourse>> getProgressCourse(
      CreateProgressCourseRequest courceRequest);
  Future<Result<ProgressProfile>> getProgressProfile(
      CreateProgressProfileRequest profileRequest);
}
