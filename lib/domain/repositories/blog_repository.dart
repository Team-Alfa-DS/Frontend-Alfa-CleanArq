
import '../../common/result.dart';
import '../entities/blog.dart';

abstract class BlogRepository{

  Future<Result<Blog>> checkManyBlogs( ManyBlogsrequest );

}