import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/category_interfaces.dart';

abstract class CategoryRepository {
  Future<Result<List<Category>>> getCategories(
      String categoryId, int page, int perPage);

  Future<Result<void>> createCategory(
      CreateCategoryRequest createCategoryRequest);
}
