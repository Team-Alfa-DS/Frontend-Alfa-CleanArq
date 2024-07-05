import 'package:bloc/bloc.dart';

import '../../../use_cases/blog/get_blog_many_use_case.dart';
import 'blog_many_event.dart';
import 'blog_many_state.dart';

class BlogListBloc extends Bloc<BlogListEvent, BlogListState> {
  final GetBlogDataUseCase _getBlogDataUseCase;

  BlogListBloc(this._getBlogDataUseCase) : super(BlogListInitial()) {
    on<LoadBlogList>(_onBlogCourseList);
  }

  Future<void> _onBlogCourseList(
      LoadBlogList event,
      Emitter<BlogListState> emit,
      ) async {
    emit(BlogListLoading());

    final result = await _getBlogDataUseCase.execute(
      GetBlogDataUseCaseInput(
          page: event.page,
          perPage: event.perPage,
          filter: event.filter,
          trainer: event.trainer,
          category: event.category)
    );

    if (result.hasValue()) {
      emit(BlogListLoaded(result.value!));
    } else {
      emit(BlogListFailed(result.failure!));
    }
  }
}