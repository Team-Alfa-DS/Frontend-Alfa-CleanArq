import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

abstract class ProgressRepository {
  Future<Result<Progress>> getProgressCourse(

      );
  Future<Result<List<Progress>>> getProgressProfile(

      );
  Future<Result<List<Progress>>> getProgressVideoMark(

      );

}