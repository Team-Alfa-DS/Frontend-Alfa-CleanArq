import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/course/course_many/course_many_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/courses/get_course_data_use_case.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  final GetCourseDataUseCase _getCourseDataUseCase;

  CourseListBloc(this._getCourseDataUseCase) : super(CourseListInitial()) {
    on<LoadCourseList>(_onLoadCourseList);
  }

  Future<void> _onLoadCourseList(
    LoadCourseList event,
    Emitter<CourseListState> emit,
  ) async {
    emit(CourseListLoading());

    final result = await _getCourseDataUseCase.execute(
      GetCourseDataUseCaseInput(
          courseId: event.courseId, page: event.page, perPage: event.perPage),
    );

    if (result.hasValue()) {
      emit(CourseListLoaded(result.value!));
    } else {
      emit(CourseListFailed(result.failure!));
    }
  }
}
