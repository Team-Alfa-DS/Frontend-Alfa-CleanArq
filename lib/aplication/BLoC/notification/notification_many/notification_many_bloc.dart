import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_many/notification_many_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_many/notification_many_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/notification/get_notification_data_use_case.dart';
import 'package:bloc/bloc.dart';

class NotificationListBloc
    extends Bloc<NotificationListEvent, NotificationListState> {
  final GetNotificationDataUseCase _getNotificationDataUseCase;

  NotificationListBloc(this._getNotificationDataUseCase)
      : super(NotificationListInitial()) {
    on<LoadNotificationList>(_onLoadNotificationList);
  }

  Future<void> _onLoadNotificationList(
    LoadNotificationList event,
    Emitter<NotificationListState> emit,
  ) async {
    emit(NotificationListLoading());

    final result = await _getNotificationDataUseCase.execute(
      GetNotificationDataUseCaseInput(),
    );

    if (result.hasValue()) {
      emit(NotificationListLoaded(result.value!));
    } else {
      emit(NotificationListFailed(result.failure!));
    }
  }
}
