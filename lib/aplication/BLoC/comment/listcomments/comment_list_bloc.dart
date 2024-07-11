import 'package:alpha_gymnastic_center/aplication/BLoC/comment/listcomments/comment_list_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/comment/get_comment_data_use_case.dart';
import 'package:bloc/bloc.dart';

import '../../../use_cases/courses/get_course_data_use_case.dart';
import 'comment_list_event.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final GetCommentDataUseCase _getCommentDataUseCase;

  CommentListBloc(this._getCommentDataUseCase) : super((CommentListInitial())) {
    on<LoadCommentList>(_onLoadCommentList);
  }

  Future<void> _onLoadCommentList(
    LoadCommentList event,
    Emitter<CommentListState> emit,
  ) async {
    emit(CommentListLoading());

    final result = await _getCommentDataUseCase.execute(
      GetCommentDataUseCaseInput(
          page: event.page,
          perpage: event.perpage,
          blog: event.blog,
          lesson: event.lesson),
    );

    if (result.hasValue()) {
      emit(CommentListLoaded(result.value!));
    } else {
      emit(CommentListFailed(result.failure!));
    }
  }
}
