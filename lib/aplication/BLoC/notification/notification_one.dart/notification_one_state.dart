import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

abstract class NotificationOneState extends Equatable {
  const NotificationOneState();

  @override
  List<Object?> get props => [];
}

class NotificationOneInitial extends NotificationOneState {}

class NotificationOneLoading extends NotificationOneState {}

class NotificationOneLoaded extends NotificationOneState {
  final Notification notification;

  const NotificationOneLoaded(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationOneFailed extends NotificationOneState {
  final Failure failure;

  const NotificationOneFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
