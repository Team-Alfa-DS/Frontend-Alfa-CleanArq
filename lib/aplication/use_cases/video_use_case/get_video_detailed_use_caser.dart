import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';
import 'package:alpha_gymnastic_center/domain/repositories/video_repository.dart';

class GetVideoDetailsUseCaseInput extends IUseCaseInput {
  final String courseId;
  final String lessonId;

  GetVideoDetailsUseCaseInput({
    required this.courseId,
    required this.lessonId,
  });
}

class GetVideoDetailsUseCase
    extends IUseCase<GetVideoDetailsUseCaseInput, Video> {
  final VideoRepository videoRepository;

  GetVideoDetailsUseCase({required this.videoRepository});

  @override
  Future<Result<Video>> execute(GetVideoDetailsUseCaseInput params) async {
    return await videoRepository.getVideoDetails(
        params.courseId, params.lessonId);
  }
}
