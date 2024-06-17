import 'package:equatable/equatable.dart';

import '../../../../common/failure.dart';
import '../../../../domain/entities/blog.dart';

abstract class BlogOneState extends Equatable {
  const BlogOneState();

  @override
  List<Object?> get props => [];
}

class BlogOneInitial extends BlogOneState {}

class BlogOneLoading extends BlogOneState {}

class BlogOneLoaded extends BlogOneState {
  final Blog blog;

  const BlogOneLoaded(this.blog);

  @override
  List<Object?> get props => [blog];
}

class BlogOneFailed extends BlogOneState {
  final Failure failure;

  const BlogOneFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}