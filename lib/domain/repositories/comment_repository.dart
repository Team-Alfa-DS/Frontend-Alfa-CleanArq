
import '../../common/result.dart';
import '../entities/comment.dart';

abstract class CommentRepository {

  Future<Result<Comment>> checkManyComments( ManyCommentsRequest );
  Future<Result<Comment>> ReleaseComments (  ReleaseComment );

}