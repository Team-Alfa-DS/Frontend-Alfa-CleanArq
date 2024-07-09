import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_not_readed/notification_not_readed_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_not_readed/notification_not_readed_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/notification/get_notification_not_readed_data_use_case.dart';
import 'package:bloc/bloc.dart';

class NotificationNotReadedBloc
    extends Bloc<NotificationNotReadedEvent, NotificationNotReadedState> {
  final GetNotificationNotReadedDataUseCase
      _getNotificationNotReadedDataUseCase;

  NotificationNotReadedBloc(this._getNotificationNotReadedDataUseCase)
      : super(NotificationNotReadedInitial()) {
    on<LoadNotificationNotReaded>(_onLoadNotificationNotReaded);
  }

  Future<void> _onLoadNotificationNotReaded(
    LoadNotificationNotReaded event,
    Emitter<NotificationNotReadedState> emit,
  ) async {
    emit(NotificationNotReadedLoading());

    final result = await _getNotificationNotReadedDataUseCase.execute(
      GetNotificationNotReadedUseCaseInput(),
    );

    if (result.hasValue()) {
      emit(NotificationNotReadedLoaded(result.value!));
    } else {
      emit(NotificationNotReadedFailed(result.failure!));
    }
  }
}
