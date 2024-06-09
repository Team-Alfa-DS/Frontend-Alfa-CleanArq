import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final GetCourseDataUseCase _getCourseDataUseCase;

  CourseDetailBloc(this._getCourseDataUseCase) : super(CourseDetailInitial()) {
    on<LoadCourseDetail>(_onLoadCourseDetail);
  }

  Future<void> _onLoadCourseDetail(
    LoadCourseDetail event,
    Emitter<CourseDetailState> emit,
  ) async {
    emit(CourseDetailLoading());

    final result = await _getCourseDataUseCase.execute(
      GetCourseDataUseCaseInput(
        courseId: event.courseId,
        page: event.page,
        perPage: event.perPage,
      ),
    );

    if (result.hasValue()) {
      emit(CourseDetailLoaded(result.value!));
    } else {
      emit(CourseDetailFailed(result.failure!));
    }
  }
}
