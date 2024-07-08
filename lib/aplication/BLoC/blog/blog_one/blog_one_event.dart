import 'package:equatable/equatable.dart';

abstract class BlogOneEvent extends Equatable {
  const BlogOneEvent();

  @override
  List<Object?> get props => [];
}

class LoadBlogOne extends BlogOneEvent {
  final String blogId;

  const LoadBlogOne({required this.blogId});

  @override
  List<Object?> get props => [blogId];
}