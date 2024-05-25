import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/trainer_interfaces.dart';

abstract class TrainerRepository {
  Future<Result<Trainer>> createTrainer(CreateTrainerRequest createRequest);
  Future<Result<Trainer>> getTrainer(String id);
}
