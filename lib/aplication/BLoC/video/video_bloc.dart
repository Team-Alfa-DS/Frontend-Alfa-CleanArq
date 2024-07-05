import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'video_event.dart';
import 'video_state.dart';
import 'package:alpha_gymnastic_center/aplication/serviceAplication/progress/progress_service.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final ProgressService progressService;

  VideoBloc(this.progressService) : super(VideoInitial()) {
    on<LoadVideoDetailEvent>(_onLoadVideoDetail);
    on<SaveVideoProgressEvent>(_onSaveVideoProgress);
  }

  Future<void> _onLoadVideoDetail(
    LoadVideoDetailEvent event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());

    final video = Video(
      id: event.lessonId,
      title:
          "Sample Video", // Puedes modificar este título si tienes un valor dinámico.
      url: event.videoUrl,
      duration:
          360, // Puedes cambiar esta duración si tienes un valor dinámico.
      idLesson: event.lessonId,
    );

    try {
      final progress =
          await progressService.getProgress(event.courseId, event.lessonId);
      emit(VideoLoaded(video, progress ?? 0));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<void> _onSaveVideoProgress(
    SaveVideoProgressEvent event,
    Emitter<VideoState> emit,
  ) async {
    try {
      await progressService.saveProgress(
        courseId: event.courseId,
        lessonId: event.lessonId,
        markAsCompleted: false,
        time: event.time,
      );
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }
}
