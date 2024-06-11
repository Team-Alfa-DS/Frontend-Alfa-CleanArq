
import '../../common/result.dart';
import '../entities/comment.dart';
import '../interfaces/comment_interfaces.dart';

abstract class CommentRepository {

  Future<Result<comment>> checkManyComments(ManyCommentsRequest request);
  Future<Result<comment>> ReleaseComment (SingleComment request);

}