import 'package:equatable/equatable.dart';

abstract class CourseDetailEvent extends Equatable {
  const CourseDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadCourseDetail extends CourseDetailEvent {
  final String courseId;
  final int page;
  final int perPage;

  const LoadCourseDetail(
      {required this.courseId, required this.page, required this.perPage});

  @override
  List<Object?> get props => [courseId];
}
