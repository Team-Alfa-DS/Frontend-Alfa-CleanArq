import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';

abstract class TrainerRepository {
  Future<Result<Trainer>> getOneTrainer(String id);
  Future<Result<String>> followTrainer(String trainerId);
  Future<Result<List<Trainer>>> getManyTrainers(
      {required int page, required int perPage, bool? userFollow});
  Future<Result<int>> trainerUserFollow();
}
