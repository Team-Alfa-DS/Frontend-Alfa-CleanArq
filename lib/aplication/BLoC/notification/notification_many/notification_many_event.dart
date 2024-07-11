import 'package:equatable/equatable.dart';

abstract class NotificationListEvent extends Equatable {
  const NotificationListEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationList extends NotificationListEvent {
  const LoadNotificationList();

  @override
  List<Object?> get props => [];
}
