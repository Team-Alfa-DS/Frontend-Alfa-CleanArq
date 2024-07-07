import 'package:alpha_gymnastic_center/aplication/use_cases/video_use_case/get_video_detailed_use_caser.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/video_use_case/save_video_porgress_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final SaveVideoProgressUseCase saveVideoProgressUseCase;

  VideoBloc({
    required this.saveVideoProgressUseCase,
  }) : super(VideoInitial()) {
    on<LoadVideoDetailEvent>(_onLoadVideoDetail);
    on<SaveVideoProgressEvent>(_onSaveVideoProgress);
  }

  Future<void> _onLoadVideoDetail(
      LoadVideoDetailEvent event, Emitter<VideoState> emit) async {
    //emit(VideoLoading());
    //emit(VideoLoaded(video: video, currentTime: currentTime))
  }

  Future<void> _onSaveVideoProgress(
      SaveVideoProgressEvent event, Emitter<VideoState> emit) async {
    print("Video Event data");
    print(event.courseId);
    print(event.lessonId);
    final result = await saveVideoProgressUseCase.execute(
      SaveVideoProgressUseCaseInput(
        courseId: event.courseId,
        lessonId: event.lessonId,
        time: event.time,
      ),
    );

    if (result.hasValue()) {
      emit(VideoProgressSaved());
    } else {
      emit(VideoError(message: result.failure!.message));
    }
  }
}
