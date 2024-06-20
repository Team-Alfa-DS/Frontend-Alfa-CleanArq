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
  Future<Result<SearchResult>> getSearchResult({String? term, List<String>? tag, required int page, required int perpage}) async {
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');

    final response = await _apiRequestManager.request('/search','GET', (data) {return SearchMapper.fromJson(data);});

    return response;
  }

}