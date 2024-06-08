import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/lesson/lesson_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/lesson/lesson_event.dart';
import 'package:alpha_gymnastic_center/domain/repositories/lesson_repository.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetLessonDataUseCase _getLessonDataUseCase;

  LessonBloc(this._getLessonDataUseCase) : super(LessonInitial()) {
    on<LoadLessonDetailEvent>(_onLoadLessonDetail);
  }

  Future<void> _onLoadLessonDetail(
    LoadLessonDetailEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoading());

    final result = await _getLessonDataUseCase.execute(
      GetLessonDataUseCaseInput(
        courseId: event.courseId,
        page: event.page,
        perPage: event.perPage,
      ),
    );

    if (result.hasValue()) {
      emit(LessonLoaded(result.value!));
    } else {
      emit(LessonFailed(result.failure!));
    }
  }
}
