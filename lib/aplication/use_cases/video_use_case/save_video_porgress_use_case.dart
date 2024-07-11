import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/video_repository.dart';

class SaveVideoProgressUseCaseInput extends IUseCaseInput {
  final String courseId;
  final String lessonId;
  final int time;
  final int totalTime;
  final bool markAsCompleted;

  SaveVideoProgressUseCaseInput({
    required this.courseId,
    required this.lessonId,
    required this.time,
    required this.totalTime,
    this.markAsCompleted = false,
  });
}

class SaveVideoProgressUseCase
    extends IUseCase<SaveVideoProgressUseCaseInput, void> {
  final VideoRepository videoRepository;

  SaveVideoProgressUseCase({required this.videoRepository});

  @override
  Future<Result<void>> execute(SaveVideoProgressUseCaseInput params) async {
    return await videoRepository.saveVideoProgress(PostProgressRequest(
        courseId: params.courseId,
        lessonId: params.lessonId,
        markAsComplete: params.markAsCompleted,
        time: params.time,
        totalTime: params.totalTime));
  }
}
