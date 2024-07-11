import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/category_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/category_repository.dart';
import 'package:image_picker/image_picker.dart';

class PostNewCategoryUseCaseInput extends IUseCaseInput {
  String name;
  XFile icon;

  PostNewCategoryUseCaseInput({required this.name, required this.icon});
}

class PostNewCategoryUseCase
    implements IUseCase<PostNewCategoryUseCaseInput, void> {
  final CategoryRepository categoryRepository;

  PostNewCategoryUseCase({required this.categoryRepository});

  @override
  Future<Result<void>> execute(PostNewCategoryUseCaseInput params) async {
    //return await categoryRepository.createCategory(targetid: params.targetid, targetType: params.targetType, body: params.body);
    final cate = CreateCategoryRequest(name: params.name, icon: params.icon);
    final result = await categoryRepository.createCategory(cate);
    print('USE CASE CATEGORY');
    print(result);
    return result;
  }
}
