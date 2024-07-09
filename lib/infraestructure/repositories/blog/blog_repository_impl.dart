import 'package:alpha_gymnastic_center/domain/repositories/blog_repository.dart';

import '../../../aplication/localStorage/local_storage.dart';
import '../../../common/result.dart';
import '../../../domain/entities/blog.dart';
import '../../datasources/api/api_request.dart';
import '../../mappers/blog/blog_mapper_many.dart';
import '../../mappers/blog/blog_mapper_one.dart';

class BlogRepositoryImpl extends BlogRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  BlogRepositoryImpl({
    required IApiRequestManager apiRequestManager,
    required LocalStorage localStorage,
  })  : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<List<Blog>>> checkManyBlogs(
      { required String filter,
        required int page,
        required int perpage,
        required String trainer,
        required String category
      }) async {
    print('Inicio de Many');
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    print('Mitad de Many');

    print('/blog/many?perPage=$perpage&page=$page&filter=$filter&trainer=$trainer&category=$category');

    try {
      final response = await _apiRequestManager.request(
        //Esto tengo que ver bien en el Swagger como se pone con todos los parametros que si filter categories etc
        '/blog/many?perPage=$perpage&page=$page&filter=$filter&trainer=$trainer&category=$category',
        'GET',
            (data) {
          print('Data received in checkManyBlogs: $data');
          List<Blog> blogs = (data as List)
              .map((blogData) => BlogMapperMany.fromJson(blogData))
              .toList();
          print('List of blogs in checkManyBlogs:');
          blogs.forEach((blog) => print(blog));
          return blogs;
        },
      );
      print('Response in checkManyBlogs:');
      print(response);
      return response;
    } catch (e) {
      print('Error in checkManyBlogs: $e');
      throw e;
    }
  }

  @override
  Future<Result<Blog>> checkOneBlog({
    required String id
  }) async {
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    final response = await _apiRequestManager
        .request<Blog>('/blog/one/$id', 'GET', (data) {
      print('Data received in checkOneBlog: $data');
      return BlogMapperOne.fromJson(data);
    });
    if (response.hasValue()) {
      final blog = response.value!;
      print('Blog in checkOneBlog:');
      print(blog);
    }
    return response;
  }

}