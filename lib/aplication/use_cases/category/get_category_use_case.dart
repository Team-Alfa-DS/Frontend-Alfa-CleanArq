import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/domain/repositories/category_repository.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class GetCategoryDataUseCaseInput extends IUseCaseInput {
  final int page;
  final int perPage;

  GetCategoryDataUseCaseInput({required this.page, required this.perPage});
}

class GetCategoryDataUseCase
    implements IUseCase<GetCategoryDataUseCaseInput, List<Category>> {
  final CategoryRepository _categoryRepository;

  GetCategoryDataUseCase(this._categoryRepository);

  @override
  Future<Result<List<Category>>> execute(
      GetCategoryDataUseCaseInput params) async {
    return await _categoryRepository.getCategories(
      params.page,
      params.perPage,
    );
  }
}
