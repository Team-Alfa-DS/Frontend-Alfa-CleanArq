import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_detail_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_case/notification/get_notification_data_use_case.dart';
import 'package:bloc/bloc.dart';

class NotificationDetailBloc
    extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  final GetNotificationDataUseCase _getNotificationDataUseCase;

  NotificationDetailBloc(this._getNotificationDataUseCase)
      : super(NotificationDetailInitial()) {
    on<LoadNotificationDetail>(_onLoadNotificationDetail);
  }

  Future<void> _onLoadNotificationDetail(
    LoadNotificationDetail event,
    Emitter<NotificationDetailState> emit,
  ) async {
    emit(NotificationDetailLoading());

    final result = await _getNotificationDataUseCase.execute(
      GetNotificationDataUseCaseInput(
        notificationId: event.notificationId,
      ),
    );

    if (result.hasValue()) {
      emit(NotificationDetailLoaded(result.value!));
    } else {
      emit(NotificationDetailFailed(result.failure!));
    }
  }
}
