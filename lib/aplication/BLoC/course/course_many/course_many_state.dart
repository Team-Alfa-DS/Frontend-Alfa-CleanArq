import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';

abstract class CourseListState extends Equatable {
  const CourseListState();

  @override
  List<Object?> get props => [];
}

class CourseListInitial extends CourseListState {}

class CourseListLoading extends CourseListState {}

class CourseListLoaded extends CourseListState {
  final List<Course> courses;

  const CourseListLoaded(this.courses);

  @override
  List<Object?> get props => [courses];
}

class CourseListFailed extends CourseListState {
  final Failure failure;

  const CourseListFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
