import 'package:equatable/equatable.dart';

abstract class NotificationOneEvent extends Equatable {
  const NotificationOneEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationOne extends NotificationOneEvent {
  final String notificationId;

  const LoadNotificationOne({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}
