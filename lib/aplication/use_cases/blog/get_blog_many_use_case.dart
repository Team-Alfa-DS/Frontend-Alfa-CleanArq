import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/entities/blog.dart';
import '../../../domain/repositories/blog_repository.dart';

class GetBlogDataUseCaseInput extends IUseCaseInput {
  final String filter;
  final int page;
  final int perPage;
  final String trainer;
  final String category;

  GetBlogDataUseCaseInput({
    required this.filter,
    required this.page,
    required this.perPage,
    required this.trainer,
    required this.category
  });

}

class GetBlogDataUseCase
    implements IUseCase<GetBlogDataUseCaseInput, List<Blog>> {
  final BlogRepository blogRepository;

  GetBlogDataUseCase({required this.blogRepository});

  @override
  Future<Result<List<Blog>>> execute(GetBlogDataUseCaseInput params) async {
    print('Entro en getManyBlogs');
    return await blogRepository.checkManyBlogs(
        page: params.page,
        perpage: params.perPage,
        filter: params.filter,
        trainer: params.trainer,
        category: params.category);
  }
}