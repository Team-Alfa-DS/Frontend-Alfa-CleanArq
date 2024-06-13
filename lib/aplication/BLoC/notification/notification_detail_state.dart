import 'package:alpha_gymnastic_center/common/failure.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationDetailState extends Equatable {
  const NotificationDetailState();

  @override
  List<Object?> get props => [];
}

class NotificationDetailInitial extends NotificationDetailState {}

class NotificationDetailLoading extends NotificationDetailState {}

class NotificationDetailLoaded extends NotificationDetailState {
  final List<Notification> notification;

  const NotificationDetailLoaded(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationDetailFailed extends NotificationDetailState {
  final Failure failure;

  const NotificationDetailFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
