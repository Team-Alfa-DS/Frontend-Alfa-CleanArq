import 'package:bloc/bloc.dart';

import '../../../use_cases/blog/get_blog_one_use_case.dart';
import 'blog_one_event.dart';
import 'blog_one_state.dart';

class blogOneBloc extends Bloc<BlogOneEvent, BlogOneState> {
  final GetSingleBlogUseCase _getBlogOneUseCase;

  blogOneBloc(this._getBlogOneUseCase)
      : super(BlogOneInitial()) {
    on<LoadBlogOne>(_onLoadBlogOne);
  }

  Future<void> _onLoadBlogOne(
      LoadBlogOne event,
      Emitter<BlogOneState> emit,
      ) async {
    emit(BlogOneLoading());

    final result = await _getBlogOneUseCase.execute(
      GetSingleBlogUseCaseInput(blogId: event.blogId),
    );

    if (result.hasValue()) {
      emit(BlogOneLoaded(result.value!));
    } else {
      emit(BlogOneFailed(result.failure!));
    }
  }
}