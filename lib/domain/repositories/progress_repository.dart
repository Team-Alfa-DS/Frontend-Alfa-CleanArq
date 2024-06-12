import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/progress.dart';

abstract class ProgressRepository {
  Future<Result<List<Progress>>> getProgressMany({
    required int page,
    required int perPage,
  });

  Future<Result<List<Progress>>> getSingleProgress({required String id});
}
