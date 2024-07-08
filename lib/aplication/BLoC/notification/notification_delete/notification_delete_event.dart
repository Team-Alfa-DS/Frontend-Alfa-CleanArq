import 'package:equatable/equatable.dart';

abstract class NotificationDeleteEvent extends Equatable {
  const NotificationDeleteEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationDelete extends NotificationDeleteEvent {
  const LoadNotificationDelete();

  @override
  List<Object?> get props => [];
}
