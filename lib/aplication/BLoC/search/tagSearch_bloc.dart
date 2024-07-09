
import 'package:alpha_gymnastic_center/aplication/use_cases/search/searchTags_use_case.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

part 'tagSearch_state.dart';
part 'tagSearch_event.dart';

class TagSearchBloc extends Bloc<TagSearchEvent, TagSearchState> {
  final SearchTagsUseCase searchTagsUseCase;

  TagSearchBloc({required this.searchTagsUseCase}) : super(TagSearchInit()) {
    on<TagSearchSent>(_onSent);
  }

  Future<void> _onSent(TagSearchSent event, Emitter<TagSearchState> emit) async {
    emit(TagSearchLoading());

    final result = await searchTagsUseCase.execute( GetTagsUseCaseInput(event.page, event.perpage));

    if (result.hasValue()) {
      emit(TagSearchSuccess(tags: result.value!));
    } else {
      emit(TagSearchFailure(failure: result.failure!));
    }
  }
}