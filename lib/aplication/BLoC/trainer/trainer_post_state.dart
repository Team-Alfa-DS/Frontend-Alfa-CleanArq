import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:equatable/equatable.dart';

abstract class TrainerPostState extends Equatable {
  const TrainerPostState();

  @override
  List<Object?> get props => [];
}

class TrainerPostInitial extends TrainerPostState {}

class TrainerPostLoading extends TrainerPostState {}

class TrainerPostLoaded extends TrainerPostState {
  final bool trainer;

  const TrainerPostLoaded(this.trainer);

  @override
  List<Object?> get props => [trainer];
}

class TrainerPostFailed extends TrainerPostState {
  final Failure failure;

  const TrainerPostFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
