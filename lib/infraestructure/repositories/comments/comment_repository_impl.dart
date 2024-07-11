import 'package:alpha_gymnastic_center/common/result.dart';

import 'package:alpha_gymnastic_center/domain/entities/comment.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/comment/comment_mapper.dart';

import '../../../aplication/localStorage/local_storage.dart';
import '../../../domain/repositories/comment_repository.dart';
import '../../datasources/api/api_request.dart';

class CommentRepositoryImpl extends CommentRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  CommentRepositoryImpl({
    required IApiRequestManager apiRequestManager,
    required LocalStorage localStorage,
  })  : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<List<Comment_>>> getManyComments({
    String? blog,
    String? lesson,
    required int page,
    required int perpage,
  }) async {
    print('Inicio de getManyComments');
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    print('Mitad de getManyComments');

    print("blog id: $blog");
    print("lesson id: $lesson");
    print("perpage: $perpage");
    print("page: $page");
    print(
        '/comment/many?perpage=$perpage&page=$page&lesson=$lesson&blog=$blog');

    try {
      final Result<List<Comment_>> response = await _apiRequestManager.request(
        '/comment/many?perPage=$perpage&page=0&lesson=$lesson&blog=$blog',
        'GET',
        (data) {
          print('Data received in comments: $data');
          List<Comment_> comments = (data as List)
              .map((commentData) => CommentMapper.fromJson(commentData))
              .toList();
          print('List of comments:');
          for (var comment in comments) {
            print(comment);
          }
          return comments;
        },
      );

      print('Response in getManyComments:');
      print(response);
      return response;
    } catch (e) {
      print('Error in getManyComments: $e');
      rethrow;
    }
  }

  @override
  Future<Result<Comment_>> releaseComment({
    required String targetid,
    required String targetType,
    required String body,
  }) async {
    try {
      await _addAuthorizationHeader();
      final token = await _localStorage.getAuthorizationToken();
      _apiRequestManager.setHeaders('Authorization', 'Bearer $token');

      final requestBody = CommentMapper.toJson(
        Comment_(targetId: targetid, body: body, targetType: targetType),
      );
      final response = await _apiRequestManager.request(
        '/comment/release',
        'POST',
        (data) => CommentMapper.fromJson(data),
        body: requestBody,
      );

      print('Release comment response: $response');
      return response;
    } catch (e) {
      print('Error releasing comment: $e');
      rethrow;
    }
  }
}
