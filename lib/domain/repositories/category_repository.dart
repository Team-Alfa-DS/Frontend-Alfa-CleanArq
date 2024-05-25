import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Result<List<Category>>> getCategories(int page, int perPage);
}
