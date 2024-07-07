import 'package:equatable/equatable.dart';

import '../../../../common/failure.dart';
import '../../../../domain/entities/comment.dart';

abstract class CommentPostState extends Equatable {
  const CommentPostState();

  @override
  List<Object?> get props => [];
}

class CommentPostInitial extends CommentPostState {}

class CommentPostLoading extends CommentPostState {}

class CommentPostLoaded extends CommentPostState {
  final Comment_ comment;

  const CommentPostLoaded(this.comment);

  @override
  List<Object?> get props => [comment];
}

class CommentPostFailed extends CommentPostState {
  final Failure failure;

  const CommentPostFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}