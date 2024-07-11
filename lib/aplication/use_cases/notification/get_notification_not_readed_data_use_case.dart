import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';

class GetNotificationNotReadedUseCaseInput extends IUseCaseInput {
  GetNotificationNotReadedUseCaseInput();
}

class GetNotificationNotReadedDataUseCase {
  final NotificationRepository _notificationRepository;

  GetNotificationNotReadedDataUseCase(
      {required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;

  Future<Result<int>> execute(GetNotificationNotReadedUseCaseInput i) {
    return _notificationRepository.getNotificationNotReaded();
  }
}
