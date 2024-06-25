import 'package:alpha_gymnastic_center/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  final User user;

  const LoadUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class ClearUser extends UserEvent {}
