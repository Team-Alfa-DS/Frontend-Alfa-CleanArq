import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/lesson/lesson_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/lesson/lesson_event.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/lessons/get_lessons_by_course_use_case.dart';

class LessonBloc extends Bloc<LessonDetailEvent, LessonDetailState> {
  final GetLessonsByCourseUseCase _getLessonDataUseCase;

  LessonBloc(this._getLessonDataUseCase) : super(const LessonDetailInitial()) {
    on<LoadLessonDetailEvent>(_onLoadLessonDetail);
  }

  Future<void> _onLoadLessonDetail(
    LoadLessonDetailEvent event,
    Emitter<LessonDetailState> emit,
  ) async {
    emit(const LessonDetailLoading());

    final result = await _getLessonDataUseCase.execute(
      GetLessonsByCourseUseCaseInput(
        courseId: event.courseId,
        page: event.page,
        perPage: event.perPage,
      ),
    );

    if (result.hasValue()) {
      emit(LessonDetailLoaded(lesson: result.value!));
    } else {
      emit(LessonDetailError(failure: result.failure!));
    }
  }
}
