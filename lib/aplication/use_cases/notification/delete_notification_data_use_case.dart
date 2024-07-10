import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';

class DeleteNotificationUseCaseInput extends IUseCaseInput {
  DeleteNotificationUseCaseInput();
}

class DeleteNotificationDataUseCase {
  final NotificationRepository _notificationRepository;

  DeleteNotificationDataUseCase(
      {required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;

  Future<Result<void>> execute(DeleteNotificationUseCaseInput i) {
    return _notificationRepository.deleteNotifications();
  }
}
