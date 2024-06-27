import 'package:equatable/equatable.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCourseList extends CourseListEvent {
  final int page;
  final int perPage;
  final String filter; // Nuevo campo para manejar el filtro

  const LoadCourseList(
      {required this.page, required this.perPage, required this.filter});

  @override
  List<Object?> get props => [page, perPage, filter];
}

class RefreshCourseList extends CourseListEvent {
  final String filter;

  const RefreshCourseList({required this.filter});

  @override
  List<Object?> get props => [filter];
}
