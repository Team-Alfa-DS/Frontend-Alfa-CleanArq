import 'package:alpha_gymnastic_center/aplication/BLoC/category/post/category_post_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/trainer/trainer_post_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/trainer/trainer_post_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/trainer/post_new_trainer_use_case.dart';
import 'package:bloc/bloc.dart';

class TrainerPostBloc extends Bloc<LoadTrainerPost, TrainerPostState> {
  final PostNewTrainerUseCase postNewTrainerUseCase;

  TrainerPostBloc({required this.postNewTrainerUseCase})
      : super((TrainerPostInitial())) {
    on<LoadTrainerPost>(_onLoadTrainerPost);
  }

  Future<void> _onLoadTrainerPost(
      LoadTrainerPost event, Emitter<TrainerPostState> emit) async {
    emit(TrainerPostLoading());

    final result = await postNewTrainerUseCase.execute(
      PostNewTrainerUseCaseInput(
          name: event.crearTrainerRequest.name,
          location: event.crearTrainerRequest.location),
    );

    print('BLOC Trainer');
    print(result);

    if (result.statusCode == '201') {
      emit(const TrainerPostLoaded(true));
    } else {
      emit(TrainerPostFailed(result.failure!));
    }
  }
}
