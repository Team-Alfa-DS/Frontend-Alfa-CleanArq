// lib/aplication/BLoC/progress/trending_progress_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/progress/get_trending_progress_use_case.dart';

part 'trending_progress_event.dart';
part 'trending_progress_state.dart';

class TrendingProgressBloc
    extends Bloc<TrendingProgressEvent, TrendingProgressState> {
  final GetTrendingProgressUseCase getTrendingProgressUseCase;

  TrendingProgressBloc({required this.getTrendingProgressUseCase})
      : super(TrendingProgressInitial()) {
    on<LoadTrendingProgress>(_onLoadTrendingProgress);
  }

  Future<void> _onLoadTrendingProgress(
      LoadTrendingProgress event, Emitter<TrendingProgressState> emit) async {
    emit(TrendingProgressLoading());

    final result = await getTrendingProgressUseCase
        .execute(GetTrendingProgressUseCaseInput());

    if (result.hasValue()) {
      emit(TrendingProgressLoaded(progress: result.value!));
    } else {
      emit(TrendingProgressError(message: result.failure!.message));
    }
  }
}
