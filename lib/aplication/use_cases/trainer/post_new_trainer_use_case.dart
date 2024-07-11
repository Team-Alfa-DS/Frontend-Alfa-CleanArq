import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/trainer_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/trainer_repository.dart';

class PostNewTrainerUseCaseInput extends IUseCaseInput {
  String name;
  String location;

  PostNewTrainerUseCaseInput({required this.name, required this.location});
}

class PostNewTrainerUseCase
    implements IUseCase<PostNewTrainerUseCaseInput, void> {
  final TrainerRepository trainerRepository;

  PostNewTrainerUseCase({required this.trainerRepository});

  @override
  Future<Result<void>> execute(PostNewTrainerUseCaseInput params) async {
    //return await categoryRepository.createCategory(targetid: params.targetid, targetType: params.targetType, body: params.body);
    final cate =
        CrearTrainerRequest(name: params.name, location: params.location);
    final result = await trainerRepository.createTrainer(cate);
    print('USE CASE TRAINER');
    print(result);
    return result;
  }
}
