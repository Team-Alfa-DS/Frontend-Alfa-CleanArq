import 'package:equatable/equatable.dart';

import '../../../../common/failure.dart';
import '../../../../domain/entities/blog.dart';

abstract class BlogListState extends Equatable {
  const BlogListState();

  @override
  List<Object?> get props => [];
}

class BlogListInitial extends BlogListState {}

class BlogListLoading extends BlogListState {}

class BlogListLoaded extends BlogListState {
  final List<Blog> blogs;

  const BlogListLoaded(this.blogs);

  @override
  List<Object?> get props => [blogs];
}

class BlogListFailed extends BlogListState {
  final Failure failure;

  const BlogListFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}