import 'package:equatable/equatable.dart';

import '../../../common/failure.dart';
import '../../../domain/entities/comment.dart';

abstract class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object?> get props => [];
}

class CommentListInitial extends CommentListState {}

class CommentListLoading extends CommentListState {}

class CommentListLoaded extends CommentListState {
  final List<Comment_> comments;

  const CommentListLoaded(this.comments);

  @override
  List<Object?> get props => [comments];
}

class CommentListFailed extends CommentListState {
  final Failure failure;

  const CommentListFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}