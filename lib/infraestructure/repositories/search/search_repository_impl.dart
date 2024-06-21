import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchResult.dart';
import 'package:alpha_gymnastic_center/domain/repositories/search_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/search/search_mapper.dart';

class SearchRepositoryImpl extends SearchRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  SearchRepositoryImpl(
    {
      required IApiRequestManager apiRequestManager,
      required LocalStorage localStorage
    }
  ) : _apiRequestManager = apiRequestManager,
      _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<SearchResult>> getSearchResult(int page, int perpage, List<String> tags, String? term ) async {
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');

    String termQuery = ''; String tagsQuery = '';
    if (term != null) {termQuery = '&term=$term&';}
    if (tags.isNotEmpty) {
      termQuery = '&tag=';
      for (int i = 0; i < tags.length; i++) {
        tagsQuery += tags[i];
        if (i < tags.length - 1) {tagsQuery += ',';}
        else {tagsQuery += '&';}
      }
    }

    final response = await _apiRequestManager.request(
      '/search?page=$termQuery$tagsQuery$page&perpage=$perpage',
      'GET', 
      (data) {return SearchMapper.fromJson(data);});

    return response;
  }

}