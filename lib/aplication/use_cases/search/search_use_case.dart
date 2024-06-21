import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchResult.dart';
import 'package:alpha_gymnastic_center/domain/repositories/search_repository.dart';

class SearchUseCase extends IUseCase<GetSearchResultUseCaseInput, SearchResult> {
  final SearchRepository searchRepository;

  SearchUseCase(
    {
      required this.searchRepository
    }
  );

  @override
  Future<Result<SearchResult>> execute(GetSearchResultUseCaseInput params) {
    final result = searchRepository.getSearchResult(params.page, params.perpage, params.tag, params.term);

    return result;
  }

  

}

class GetSearchResultUseCaseInput extends IUseCaseInput {
  final int page;
  final int perpage;
  final List<String> tag;
  final String? term;
  
  GetSearchResultUseCaseInput(
    this.page,
    this.perpage,
    this.tag,
    this.term
    // {
    //   required this.page,
    //   required this.perpage,
    //   required this.tag,
    //   this.term
    // }
  );
}