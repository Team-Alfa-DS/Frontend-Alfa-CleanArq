import 'package:equatable/equatable.dart';

abstract class CommentListEvent extends Equatable {
  const CommentListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCommentList extends CommentListEvent {
  final int page;
  final int perpage;
  final String? blog;
  final String? lesson;

  const LoadCommentList({required this.page, required this.perpage, this.blog, this.lesson});

  @override
  List<Object?> get props => [page, perpage, blog, lesson];
}