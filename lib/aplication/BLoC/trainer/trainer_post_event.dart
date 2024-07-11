import 'package:alpha_gymnastic_center/domain/interfaces/trainer_interfaces.dart';
import 'package:equatable/equatable.dart';

abstract class TrainerPostEvent extends Equatable {
  const TrainerPostEvent();

  @override
  List<Object?> get props => [];
}

class LoadTrainerPost extends TrainerPostEvent {
  final CrearTrainerRequest crearTrainerRequest;

  const LoadTrainerPost({required this.crearTrainerRequest});

  @override
  List<Object?> get props => [crearTrainerRequest];
}
