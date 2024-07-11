import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/category_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/category_repository.dart';

class PostNewCategoryUseCaseInput extends IUseCaseInput {
  String name;
  String icon;

  PostNewCategoryUseCaseInput({required this.name, required this.icon});
}

class PostNewCategoryUseCase
    implements IUseCase<PostNewCategoryUseCaseInput, Category> {
  final CategoryRepository categoryRepository;

  PostNewCategoryUseCase({required this.categoryRepository});

  @override
  Future<Result<Category>> execute(PostNewCategoryUseCaseInput params) async {
    print('Se creo una categoria');
    //return await categoryRepository.createCategory(targetid: params.targetid, targetType: params.targetType, body: params.body);
    final cate = CreateCategoryRequest(name: params.name, icon: params.icon);
    return await categoryRepository.createCategory(cate);
  }
}
