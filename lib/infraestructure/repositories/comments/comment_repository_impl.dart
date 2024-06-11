import 'package:alpha_gymnastic_center/common/result.dart';

import 'package:alpha_gymnastic_center/domain/entities/comment.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/comment/comment_mapper.dart';

import '../../../domain/interfaces/comment_interfaces.dart';
import '../../../domain/repositories/comment_repository.dart';
import '../../datasources/api/api_request.dart';

class CommentRepositoryImpl extends CommentRepository {
  final IApiRequestManager _apiRequestManager;

  CommentRepositoryImpl({required IApiRequestManager apiRequestManager})
      : _apiRequestManager = apiRequestManager;

  @override
  Future<Result<comment>> ReleaseComment(SingleComment POSTRequest) async {
    final response = await _apiRequestManager.request<comment>(
        '/comment/release',
        'POST',
            (data) {
          return CommentMapper.fromJson(data['comment']);
        },
        body: {
          'target': POSTRequest.target,
          'targetType': POSTRequest.targettype,
          'body': POSTRequest.body,
          'token': POSTRequest.token,
        },
    );

    return response;
  }

  @override
  Future<Result<comment>> checkManyComments(ManyCommentsRequest GETrequest) async {
    final response = await _apiRequestManager.request<comment>(
      '/comments/many',
      'GET',
      (data) {
            return CommentMapper.fromJson(data);
      }


    );

    return response;
  }


}