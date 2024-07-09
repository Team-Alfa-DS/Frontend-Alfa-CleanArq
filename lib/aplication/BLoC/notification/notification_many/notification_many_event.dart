import 'package:equatable/equatable.dart';

abstract class NotificationListEvent extends Equatable {
  const NotificationListEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationList extends NotificationListEvent {
  final int page;
  final int perPage;

  const LoadNotificationList({required this.page, required this.perPage});

  @override
  List<Object?> get props => [page, perPage];
}
