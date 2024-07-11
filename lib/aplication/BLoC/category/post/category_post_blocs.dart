import 'package:alpha_gymnastic_center/aplication/BLoC/category/post/category_post_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/category/post/category_post_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/category/post_new_Category_use_case.dart';
import 'package:bloc/bloc.dart';

class CategoryPostBloc extends Bloc<LoadCategoryPost, CategoryPostState> {
  final PostNewCategoryUseCase postNewCategoryUseCase;

  CategoryPostBloc({required this.postNewCategoryUseCase})
      : super((CategoryPostInitial())) {
    on<LoadCategoryPost>(_onLoadCategoryPost);
  }

  Future<void> _onLoadCategoryPost(
      LoadCategoryPost event, Emitter<CategoryPostState> emit) async {
    emit(CategoryPostLoading());

    final result = await postNewCategoryUseCase.execute(
      PostNewCategoryUseCaseInput(
          name: event.createCategoryRequest.name,
          icon: event.createCategoryRequest.icon),
    );

    if (result.hasValue()) {
      emit(CategoryPostLoaded(result.value!));
    } else {
      emit(CategoryPostFailed(result.failure!));
    }
  }
}
