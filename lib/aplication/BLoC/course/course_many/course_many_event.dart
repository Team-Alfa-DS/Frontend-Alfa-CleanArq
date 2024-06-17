import 'package:equatable/equatable.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCourseList extends CourseListEvent {
  final int page;
  final int perpage;

  const LoadCourseList({required this.page, required this.perpage});

  @override
  List<Object?> get props => [page, perpage];
}
