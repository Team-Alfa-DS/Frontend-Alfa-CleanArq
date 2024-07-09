import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

abstract class NotificationDeleteState extends Equatable {
  const NotificationDeleteState();

  @override
  List<Object?> get props => [];
}

class NotificationDeleteInitial extends NotificationDeleteState {}

class NotificationDeleteLoading extends NotificationDeleteState {}

class NotificationDeleteLoaded extends NotificationDeleteState {
  @override
  List<Object?> get props => [];
}

class NotificationDeleteFailed extends NotificationDeleteState {
  final Failure failure;

  const NotificationDeleteFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
