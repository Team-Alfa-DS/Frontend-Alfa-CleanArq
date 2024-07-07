

import '../../common/result.dart';
import '../entities/comment.dart';

abstract class CommentRepository {

  Future<Result<List<Comment_>>> getManyComments({
      required int page,
      required int perpage,
      String? blog,
      String? lesson
  });

  Future<Result<Comment_>> releaseComment({
     required String targetid,
     required String targetType,
     required String body,
   });
}