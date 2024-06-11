import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';

abstract class CourseDetailState extends Equatable {
  const CourseDetailState();

  @override
  List<Object?> get props => [];
}

class CourseDetailInitial extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final List<Course> courses;

  const CourseDetailLoaded(this.courses);

  @override
  List<Object?> get props => [courses];
}

class CourseDetailFailed extends CourseDetailState {
  final Failure failure;

  const CourseDetailFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
