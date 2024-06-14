import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';

abstract class VideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final Video video;
  final int currentTime;

  VideoLoaded(this.video, this.currentTime);

  @override
  List<Object?> get props => [video, currentTime];
}

class VideoError extends VideoState {
  final String message;

  VideoError(this.message);

  @override
  List<Object?> get props => [message];
}
