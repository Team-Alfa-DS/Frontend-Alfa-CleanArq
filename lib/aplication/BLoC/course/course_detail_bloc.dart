import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_one_course_use_case.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final GetSingleCourseUseCase _getSingleCourseUseCase;

  CourseDetailBloc(this._getSingleCourseUseCase)
      : super(CourseDetailInitial()) {
    on<LoadCourseDetail>(_onLoadCourseDetail);
  }

  Future<void> _onLoadCourseDetail(
    LoadCourseDetail event,
    Emitter<CourseDetailState> emit,
  ) async {
    emit(CourseDetailLoading());

    final result = await _getSingleCourseUseCase.execute(
      GetSingleCourseUseCaseInput(courseId: event.courseId),
    );

    if (result.hasValue()) {
      emit(CourseDetailLoaded(result.value!));
    } else {
      emit(CourseDetailFailed(result.failure!));
    }
  }
}
