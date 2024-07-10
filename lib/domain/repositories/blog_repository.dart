
import '../../common/result.dart';
import '../entities/blog.dart';

abstract class BlogRepository{

  Future<Result<List<Blog>>> checkManyBlogs({
    required String filter,
    required int page,
    required int perpage,
    required String trainer,
    required String category
  });

  Future<Result<Blog>> checkOneBlog({required String id });

}