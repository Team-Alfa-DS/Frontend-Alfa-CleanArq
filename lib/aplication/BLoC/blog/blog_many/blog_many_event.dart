import 'package:equatable/equatable.dart';

abstract class BlogListEvent extends Equatable {
  const BlogListEvent();

  @override
  List<Object?> get props => [];
}

class LoadBlogList extends BlogListEvent {

  final String filter;
  final int page;
  final int perPage;
  final String trainer;
  final String category;

  const LoadBlogList({
    required this.filter,
    required this.page,
    required this.perPage,
    required this.trainer,
    required this.category});

  @override
  List<Object?> get props => [filter, page, perPage, trainer, category];
}