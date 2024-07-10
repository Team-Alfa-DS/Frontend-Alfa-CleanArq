import 'package:alpha_gymnastic_center/aplication/use_cases/search/search_use_case.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchResult.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;
  
  SearchBloc({required this.searchUseCase}) : super(SearchInit()) {
    on<SearchSent>(_onSent);
  }

  Future<void> _onSent(SearchSent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    print('Search Sent $event');
    final result = await searchUseCase.execute( GetSearchResultUseCaseInput(event.page, event.perpage, event.tags, event.term));
    
    if (result.hasValue()) {
      emit(SearchSuccess(result: result.value!));
    } else {
      emit(SearchFailure(failure: result.failure!));
    }

  }
}

