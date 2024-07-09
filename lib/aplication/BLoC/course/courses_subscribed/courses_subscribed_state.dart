import 'package:equatable/equatable.dart';
import '../../../../common/failure.dart';
import '../../../../domain/entities/course.dart';

sealed class CoursesSubscribedState extends Equatable {
  const CoursesSubscribedState();

  @override
  List<Object?> get props => [];
}

class CoursesSubscribedInitial extends CoursesSubscribedState {}

class CoursesSubscribedLoading extends CoursesSubscribedState {}


class CoursesSubscribedLoaded extends CoursesSubscribedState {
  final List<Course> courses;

  const CoursesSubscribedLoaded(this.courses);

  @override
  List<Object?> get props => [courses];
}

class CoursesSubscribedFailed extends CoursesSubscribedState {
  final Failure failure;

  const CoursesSubscribedFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
