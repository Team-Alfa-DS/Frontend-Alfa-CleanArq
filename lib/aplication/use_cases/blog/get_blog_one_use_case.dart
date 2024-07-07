import 'package:alpha_gymnastic_center/domain/repositories/blog_repository.dart';

import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/entities/blog.dart';

class GetSingleBlogUseCaseInput extends IUseCaseInput {
  final String blogId;

  GetSingleBlogUseCaseInput({required this.blogId});
}

class GetSingleBlogUseCase
    implements IUseCase<GetSingleBlogUseCaseInput, Blog> {
  final BlogRepository blogRepository;

  GetSingleBlogUseCase({required this.blogRepository});

  @override
  Future<Result<Blog>> execute(GetSingleBlogUseCaseInput params) async {
    final result = await blogRepository.checkOneBlog(id: params.blogId);
    print("Result usecase");
    print(result.value);
    if (result.hasValue()) {
      final blog = result.value!;
      print('Blog ID: ${blog.id}');
      print('Blog Title : ${blog.title}');
    }
    return result;
  }
}