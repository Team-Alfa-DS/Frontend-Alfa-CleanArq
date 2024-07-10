import 'package:equatable/equatable.dart';

abstract class CoursesSubscribedEvent extends Equatable {
  const CoursesSubscribedEvent();

  @override
  List<Object?> get props => [];
}

class LoadCoursesSubscribed extends CoursesSubscribedEvent {
  final int page;
  final int perPage;

  const LoadCoursesSubscribed({required this.page, required this.perPage});

  @override
  List<Object?> get props => [page, perPage];
}
