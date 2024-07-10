import 'package:alpha_gymnastic_center/aplication/use_cases/trainer/get_many_trainers_use_case.dart';
import 'package:bloc/bloc.dart';

import '../../../use_cases/courses/get_course_data_use_case.dart';
import 'courses_subscribed_event.dart';
import 'courses_subscribed_state.dart';

class CoursesSubscribedBloc
    extends Bloc<CoursesSubscribedEvent, CoursesSubscribedState> {
  final GetCourseDataUseCase _getCourseDataUseCase;
  final GetManyTrainersUseCase _getManyTrainersUseCase;

  CoursesSubscribedBloc(
      this._getCourseDataUseCase, this._getManyTrainersUseCase)
      : super(CoursesSubscribedInitial()) {
    on<LoadCoursesSubscribed>(_onLoadCoursesSubscribed);
  }

  Future<void> _onLoadCoursesSubscribed(
    LoadCoursesSubscribed event,
    Emitter<CoursesSubscribedState> emit,
  ) async {
    emit(CoursesSubscribedLoading());

    //* Obtener todos los cursos
    /*final courses = await _getCourseDataUseCase.execute(
      GetCourseDataUseCaseInput(page: event.page, perPage: event.perPage),
    );*/

    //*Obtener Trainers
    final trainers = await _getManyTrainersUseCase.execute(
      GetManyTrainersUseCaseInput(page: event.page, perPage: event.perPage),
    );

    //* Hacer match
    //   if (courses.hasValue() && trainers.hasValue()) {
    //     List<Course> coursesSubscribed = courses.value.where((curso) {
    //   return trainers.value.every((value) => curso.contains(value.id));
    // }).toList();

    // if (result.hasValue()) {
    //   emit(CoursesSubscribedLoaded(result.value!));
    // } else {
    //   emit(CoursesSubscribedFailed(result.failure!));
    // }
  }
}
