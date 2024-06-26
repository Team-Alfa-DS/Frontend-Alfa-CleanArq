import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/domain/repositories/category_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/category/category_mapper.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final IApiRequestManager _apiRequestManager;

  CategoryRepositoryImpl({required IApiRequestManager apiRequestManager})
      : _apiRequestManager = apiRequestManager;

  @override
  Future<Result<List<Category>>> getCategories(
      String categoryId, page, int perPage) async {
    final response = await _apiRequestManager.request<List<Category>>(
      '/categories?page=$page&per_page=$perPage',
      'GET',
      (data) {
        final List<dynamic> categoriesData = data;
        return categoriesData
            .map((categoryData) => CategoryMapper.fromJson(categoryData))
            .toList();
      },
    );

    return response;
  }
}
