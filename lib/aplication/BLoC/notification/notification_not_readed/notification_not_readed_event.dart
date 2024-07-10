import 'package:equatable/equatable.dart';

abstract class NotificationNotReadedEvent extends Equatable {
  const NotificationNotReadedEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationNotReaded extends NotificationNotReadedEvent {
  final int count;

  const LoadNotificationNotReaded(this.count);

  @override
  List<Object?> get props => [count];
}
