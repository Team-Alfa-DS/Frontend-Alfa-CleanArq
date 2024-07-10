import 'package:bloc/bloc.dart';
import '../../../use_cases/comment/post_new_comment_use_case.dart';
import 'comment_post_event.dart';
import 'comment_post_state.dart';

class CommentPostBloc extends Bloc<LoadCommentPost, CommentPostState> {
  final PostNewCommentUseCase _postNewCommentUseCase;

  CommentPostBloc(this._postNewCommentUseCase) : super((CommentPostInitial())) {
    on<LoadCommentPost>(_onLoadCommentPost);
  }

  Future<void> _onLoadCommentPost(
    LoadCommentPost event,
    Emitter<CommentPostState> emit,
  ) async {
    emit(CommentPostLoading());

    final result = await _postNewCommentUseCase.execute(
      PostNewCommentUseCaseInput(
          body: event.body,
          targetid: event.targetid,
          targetType: event.targetType),
    );

    if (result.hasValue()) {
      emit(CommentPostLoaded(result.value!));
    } else {
      emit(CommentPostFailed(result.failure!));
    }
  }
}
