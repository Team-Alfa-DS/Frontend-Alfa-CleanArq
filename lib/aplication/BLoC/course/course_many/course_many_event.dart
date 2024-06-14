import 'package:equatable/equatable.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCourseList extends CourseListEvent {
  final String courseId;
  final int page;
  final int perPage;

  const LoadCourseList(
      {required this.courseId, required this.page, required this.perPage});

  @override
  List<Object?> get props => [courseId, page, perPage];
}
