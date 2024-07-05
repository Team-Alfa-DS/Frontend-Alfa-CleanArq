import 'package:alpha_gymnastic_center/domain/repositories/comment_repository.dart';

import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/entities/comment.dart';

class GetCommentDataUseCaseInput extends IUseCaseInput {
  final int page;
  final int perpage;
  final String? blog;
  final String? lesson;

  GetCommentDataUseCaseInput({required this.page, required this.perpage, this.blog, this.lesson});
}

class GetCommentDataUseCase
    implements IUseCase<GetCommentDataUseCaseInput, List<Comment_>> {
  final CommentRepository commentRepository;

  GetCommentDataUseCase({required this.commentRepository});

  @override
  Future<Result<List<Comment_>>> execute(GetCommentDataUseCaseInput params) async {
    print('Entro en getMany');
    return await commentRepository.getManyComments(
        page: params.page, perpage: params.perpage, blog: params.blog, lesson: params.lesson);
  }
}