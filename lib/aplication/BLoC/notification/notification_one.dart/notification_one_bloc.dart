import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_one.dart/notification_one_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/notification/notification_one.dart/notification_one_state.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/notification/get_one_notification_use_case.dart';
import 'package:bloc/bloc.dart';

class NotificationOneBloc
    extends Bloc<NotificationOneEvent, NotificationOneState> {
  final GetSingleNotificationUseCase _getSingleNotificationUseCase;

  NotificationOneBloc(this._getSingleNotificationUseCase)
      : super(NotificationOneInitial()) {
    on<LoadNotificationOne>(_onLoadNotificationOne);
  }

  Future<void> _onLoadNotificationOne(
    LoadNotificationOne event,
    Emitter<NotificationOneState> emit,
  ) async {
    emit(NotificationOneLoading());

    final result = await _getSingleNotificationUseCase.execute(
      GetSingleNotificationUseCaseInput(notificationId: event.notificationId),
    );

    if (result.hasValue()) {
      emit(NotificationOneLoaded(result.value!));
    } else {
      emit(NotificationOneFailed(result.failure!));
    }
  }
}
