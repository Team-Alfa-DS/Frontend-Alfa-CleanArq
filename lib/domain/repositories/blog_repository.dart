import 'package:alpha_gymnastic_center/domain/interfaces/blog_interfaces.dart';

import '../../common/result.dart';
import '../entities/blog.dart';

abstract class BlogRepository{

  Future<Result<Blog>> checkManyBlogs( ManyBlogsrequest );

}