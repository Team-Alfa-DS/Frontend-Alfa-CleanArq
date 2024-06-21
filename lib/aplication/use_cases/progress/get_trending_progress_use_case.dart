// lib/aplication/use_cases/progress/get_trending_progress_use_case.dart

import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/repositories/progress_repository.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

class GetTrendingProgressUseCaseInput extends IUseCaseInput {}

class GetTrendingProgressUseCase extends IUseCase<
    GetTrendingProgressUseCaseInput, List<TrendingProgressResponse>> {
  final ProgressRepository progressRepository;

  GetTrendingProgressUseCase({required this.progressRepository});

  @override
  Future<Result<List<TrendingProgressResponse>>> execute(
      GetTrendingProgressUseCaseInput params) async {
    final result = await progressRepository.getTrendingProgress();
    return result;
  }
}
