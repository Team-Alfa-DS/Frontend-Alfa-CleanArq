import 'package:equatable/equatable.dart';

abstract class NotificationDetailEvent extends Equatable {
  const NotificationDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationDetail extends NotificationDetailEvent {
  final String notificationId;

  const LoadNotificationDetail({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}
