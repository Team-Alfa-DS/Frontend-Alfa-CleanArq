import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';

abstract class CourseListState extends Equatable {
  const CourseListState();

  @override
  List<Object?> get props => [];
}

class CourseListInitial extends CourseListState {}

class CourseListLoading extends CourseListState {
  final List<Course> courses;

  const CourseListLoading(this.courses);

  @override
  List<Object?> get props => [courses];
}

class CourseListLoaded extends CourseListState {
  final List<Course> courses;
  final bool hasReachedMax;
  final int page;

  const CourseListLoaded({
    required this.courses,
    required this.hasReachedMax,
    this.page = 1,
  });

  CourseListLoaded copyWith({
    List<Course>? courses,
    bool? hasReachedMax,
    int? page,
  }) {
    return CourseListLoaded(
      courses: courses ?? this.courses,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [courses, hasReachedMax, page];
}

class CourseListFailed extends CourseListState {
  final Failure failure;

  const CourseListFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
