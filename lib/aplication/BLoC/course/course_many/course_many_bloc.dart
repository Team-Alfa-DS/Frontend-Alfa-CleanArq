import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
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
    if (state is CourseListInitial || state is CourseListLoaded) {
      try {
        final currentState = state;

        final result = await _getCourseDataUseCase.execute(
          GetCourseDataUseCaseInput(
              page: event.page, perPage: event.perPage, filter: event.filter),
        );

        if (result.hasValue()) {
          if (currentState is CourseListLoaded) {
            final updatedCourses = [...currentState.courses, ...result.value!];
            emit(currentState.copyWith(
              courses: updatedCourses,
              hasReachedMax: result.value!.isEmpty,
              page: event.page,
            ));
          } else {
            emit(CourseListLoaded(
              courses: result.value!,
              hasReachedMax: result.value!.isEmpty,
              page: event.page,
            ));
          }
        } else {
          if (currentState is CourseListLoaded) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
        }
      } catch (e) {
        print('Error in CourseListBloc: $e');
        emit(const CourseListFailed(ServerFailure()));
      }
    }
  }
}
