import 'package:alpha_gymnastic_center/aplication/use_cases/video_use_case/get_videos_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:equatable/equatable.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideosUseCase getVideosUseCase;

  VideosBloc({required this.getVideosUseCase}) : super(VideoInitial()) {
    on<LoadVideos>(_onLoadVideos);
  }

  Future<void> _onLoadVideos(
      LoadVideos event, Emitter<VideosState> emit) async {
    emit(VideoLoading());
    try {
      final result = await getVideosUseCase.execute(GetVideosUseCaseInput());
      if (result.hasValue()) {
        emit(VideoLoaded(courses: result.value!));
      } else {
        emit(VideoError(message: result.failure!.message));
      }
    } catch (error) {
      emit(VideoError(message: error.toString()));
    }
  }
}
