import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

abstract class NotificationListState extends Equatable {
  const NotificationListState();

  @override
  List<Object?> get props => [];
}

class NotificationListInitial extends NotificationListState {}

class NotificationListLoading extends NotificationListState {}

class NotificationListLoaded extends NotificationListState {
  final List<Notifications> notification;

  const NotificationListLoaded(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationListFailed extends NotificationListState {
  final Failure failure;

  const NotificationListFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
