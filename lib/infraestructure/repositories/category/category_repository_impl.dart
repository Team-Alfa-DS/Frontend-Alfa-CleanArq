import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/domain/entities/category.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/category_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/category_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:path/path.dart'; // Import the path package
import 'package:alpha_gymnastic_center/infraestructure/datasources/localStorage/loca_storage_imp.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/category/category_mapper.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:http_parser/http_parser.dart'; // Import http_parser for MediaType

class CategoryRepositoryImpl extends CategoryRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  CategoryRepositoryImpl(
      {required IApiRequestManager apiRequestManager,
      required LocalStorage localStorage})
      : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

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

  @override
  Future<Result<void>> createCategory(
      CreateCategoryRequest createCategoryRequest) async {
    print(createCategoryRequest.name);
    print(createCategoryRequest.icon);

    final token = await _localStorage.getAuthorizationToken();

     final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://backend-alfa-hexa-production.up.railway.app/category/create'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'icon',
        createCategoryRequest.icon.path,
        filename: basename(createCategoryRequest.icon.path),
        contentType: MediaType('image', 'jpeg'), // Cambiar si el tipo de imagen es diferente
      ),
    );

    request.fields['name'] = createCategoryRequest.name;

    // Agregar el token de autenticación en los encabezados
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

     final response = await request.send();

    if (response.statusCode == 201) {
      print('Image uploaded successfully!');
    } else {
      print('Image upload failed with status: ${response.statusCode}');
      final responseData = await response.stream.bytesToString();
      print('Response data: $responseData');
    }
    print('REPOSITORY CATEGORY');
    print(response);
    print(response.statusCode);
    return  Result<void>(
          value: null,
          failure: null,
          statusCode: response.statusCode.toString());
  }
}
