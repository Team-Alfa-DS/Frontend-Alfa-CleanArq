import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_delete/notification_delete_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_delete/notification_delete_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/notification/delete_notification_data_use_case.dart';
import 'package:bloc/bloc.dart';

class NotificationDeleteBloc
    extends Bloc<NotificationDeleteEvent, NotificationDeleteState> {
  final DeleteNotificationDataUseCase _deleteNotificationDataUseCase;

  NotificationDeleteBloc(this._deleteNotificationDataUseCase)
      : super(NotificationDeleteInitial()) {
    on<NotificationDeleteEvent>(_onDeleteNotificationsEvent);
  }

  Future<void> _onDeleteNotificationsEvent(NotificationDeleteEvent event,
      Emitter<NotificationDeleteState> emit) async {
    emit(NotificationDeleteLoading());

    final result = await _deleteNotificationDataUseCase.execute(
      DeleteNotificationUseCaseInput(),
    );

    if (result.hasValue()) {
      emit(NotificationDeleteLoaded());
    } else {
      emit(NotificationDeleteFailed(result.failure!));
    }
  }
}
