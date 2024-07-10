import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/domain/repositories/category_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/category/category_mapper.dart';
import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  CategoryRepositoryImpl({
    required IApiRequestManager apiRequestManager,
    required LocalStorage localStorage,
  })  : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<List<Category>>> getCategories(int page, int perPage) async {
    try {
      await _addAuthorizationHeader();
      final response = await _apiRequestManager.request(
        '/category/many?page=$page&perpage=$perPage',
        'GET',
        (data) {
          List<Category> categories = (data['categories'] as List)
              .map((categoryData) => CategoryMapper.fromJson(categoryData))
              .toList();
          return categories;
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
