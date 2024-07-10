import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/repositories/trainer_repository.dart';

class GetManyTrainersUseCaseInput extends IUseCaseInput {
  final int page;
  final int perPage;

  GetManyTrainersUseCaseInput({required this.page, required this.perPage});
}

class GetManyTrainersUseCase
    implements IUseCase<GetManyTrainersUseCaseInput, List<Trainer>> {
  //TODO:
  //*Traer lista de Trainers
  //*Traer lista de cursos
  //* Relacionar ambos
  //*Retornar Lista de cursos a los que esta suscrito el user por trainer

  final TrainerRepository trainerRepository;

  GetManyTrainersUseCase({required this.trainerRepository});

  @override
  Future<Result<List<Trainer>>> execute(
      GetManyTrainersUseCaseInput params) async {
    print('Entro en getManyTrainer');
    return await trainerRepository.getManyTrainers(
        page: params.page, perPage: params.perPage);
  }
}
