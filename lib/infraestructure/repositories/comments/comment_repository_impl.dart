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

    try {
      final Result<List<Comment_>> response = await _apiRequestManager.request(
        '/comments/many?perPage=$perpage&page=$page&lesson=$lesson&blog=$blog',
        'GET',
            (data) {
          print('Data received in comments: $data');
          List<Comment_> comments = (data['blogComments'] as List)
              .map((commentData) => CommentMapper.fromJson(commentData))
              .toList();
          print('List of comments:');
          comments.forEach((comment) => print(comment));
          return comments;
        },
      );

      print('Response in getManyComments:');
      print(response);
      return response;
    } catch (e) {
      print('Error in getManyComments: $e');
      throw e;
    }
  }

  @override
  Future<Result<Comment_>> releaseComment({
    required String targetid,
    required String targetType,
    required String body,
  }) async {
    try {

      // Add authorization header
      await _addAuthorizationHeader();
      final token = await _localStorage.getAuthorizationToken();
      _apiRequestManager.setHeaders('Authorization', 'Bearer $token');

      // Prepare request body
      final requestBody = CommentMapper.toJson(
        Comment_(id: targetid, body: body, targetType: targetType),
      );

      // Make API request
      final response = await _apiRequestManager.request(
        '/comment/release',
        'POST',
            (data) => CommentMapper.fromJson(data),
        body: requestBody,
      );

      // Log the response (for debugging purposes)
      print('Release comment response: $response');

      return response;
    } catch (e) {
      // Handle exceptions
      print('Error releasing comment: $e');
      rethrow;
    }
  }




}