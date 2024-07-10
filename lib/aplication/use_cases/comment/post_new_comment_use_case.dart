
import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/repositories/comment_repository.dart';

class PostNewCommentUseCaseInput extends IUseCaseInput {

  String body;
  String targetid;
  String targetType;

  PostNewCommentUseCaseInput({required this.body, required this.targetid, required this.targetType});
}

class PostNewCommentUseCase
    implements IUseCase<PostNewCommentUseCaseInput, Comment_> {
  final CommentRepository commentRepository;

  PostNewCommentUseCase({required this.commentRepository});

  @override
  Future<Result<Comment_>> execute(PostNewCommentUseCaseInput params) async {
    print('Entro a Poster new Comment');
    return await commentRepository.releaseComment(targetid: params.targetid, targetType: params.targetType, body: params.body);
  }
}