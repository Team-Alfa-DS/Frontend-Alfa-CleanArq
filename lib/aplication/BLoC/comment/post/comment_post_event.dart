import 'package:equatable/equatable.dart';

abstract class CommentPostEvent extends Equatable {
  const CommentPostEvent();

  @override
  List<Object?> get props => [];
}

class LoadCommentPost extends CommentPostEvent {
  final String body;
  final String targetid;
  final String targetType;

  const LoadCommentPost({required this.body, required this.targetid, required this.targetType});

  @override
  List<Object?> get props => [body,targetid,targetType];
}