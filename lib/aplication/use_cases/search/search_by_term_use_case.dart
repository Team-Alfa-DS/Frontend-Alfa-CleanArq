import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchResult.dart';
import 'package:alpha_gymnastic_center/domain/repositories/search_repository.dart';

class SearchByTermUseCase extends IUseCase<SearchByTermUseCaseInput, SearchResult> {
  final SearchRepository searchRepository;

  SearchByTermUseCase(
    {
      required this.searchRepository
    }
  );

  @override
  Future<Result<SearchResult>> execute(SearchByTermUseCaseInput params) {
    final result = searchRepository.getSearchResult(
                                          term: params.term,
                                          page: params.page, 
                                          perpage: params.perpage
                                          );

    return result;
  }

  

}

class SearchByTermUseCaseInput extends IUseCaseInput {
  final int page;
  final int perpage;
  final String term;
  
  SearchByTermUseCaseInput(
    {
      required this.page,
      required this.perpage,
      required this.term
    }
  );
}