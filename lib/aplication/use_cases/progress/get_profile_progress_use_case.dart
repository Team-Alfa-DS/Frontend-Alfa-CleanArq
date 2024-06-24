// lib/aplication/use_cases/progress/get_profile_progress_use_case.dart

import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/repositories/progress_repository.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

class GetProfileProgressUseCaseInput extends IUseCaseInput {}

class GetProfileProgressUseCase
    extends IUseCase<GetProfileProgressUseCaseInput, ProfileProgressResponse> {
  final ProgressRepository progressRepository;

  GetProfileProgressUseCase({required this.progressRepository});

  @override
  Future<Result<ProfileProgressResponse>> execute(
      GetProfileProgressUseCaseInput params) async {
    final result = await progressRepository.getProfileProgress();
    return result;
  }
}
