import 'package:equatable/equatable.dart';
import 'package:alpha_gymnastic_center/common/failure.dart';

abstract class NotificationNotReadedState extends Equatable {
  const NotificationNotReadedState();

  @override
  List<Object?> get props => [];
}

class NotificationNotReadedInitial extends NotificationNotReadedState {}

class NotificationNotReadedLoading extends NotificationNotReadedState {}

class NotificationNotReadedLoaded extends NotificationNotReadedState {
  final int count;

  const NotificationNotReadedLoaded(this.count);

  @override
  List<Object?> get props => [count];
}

class NotificationNotReadedFailed extends NotificationNotReadedState {
  final Failure failure;

  const NotificationNotReadedFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
