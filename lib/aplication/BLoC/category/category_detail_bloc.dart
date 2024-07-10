import 'package:bloc/bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/category/category_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/category/category_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/category/get_category_use_case.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final GetCategoryDataUseCase _getCategoryDataUseCase;

  CategoryDetailBloc(this._getCategoryDataUseCase)
      : super(CategoryDetailInitial()) {
    on<LoadCategoryDetail>(_onLoadCategoryDetail);
  }

  Future<void> _onLoadCategoryDetail(
    LoadCategoryDetail event,
    Emitter<CategoryDetailState> emit,
  ) async {
    emit(CategoryDetailLoading());

    final result = await _getCategoryDataUseCase.execute(
      GetCategoryDataUseCaseInput(
        page: event.page,
        perPage: event.perPage,
      ),
    );

    if (result.hasValue()) {
      emit(CategoryDetailLoaded(result.value!));
    } else {
      emit(CategoryDetailFailed(result.failure!));
    }
  }
}
