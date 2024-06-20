import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchResult.dart';

abstract class SearchRepository {
  Future<Result<SearchResult>> getSearchResult(
    {
      String term,
      List<String> tag,
      required int page,
      required int perpage
    }
  );
}