import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/repositories/search_repository.dart';

class SearchTagsUseCase extends IUseCase<GetTagsUseCaseInput, List<String>> {
  final SearchRepository searchRepository;

  SearchTagsUseCase(
    {
      required this.searchRepository
    }
  );

  @override
  Future<Result<List<String>>> execute(GetTagsUseCaseInput params) {
    final result = searchRepository.getSearchTags(params.page, params.perpage);
  
    return result;
  }
}

class GetTagsUseCaseInput extends IUseCaseInput {
  final int page;
  final int perpage;

  GetTagsUseCaseInput(
    this.page,
    this.perpage
  );
}