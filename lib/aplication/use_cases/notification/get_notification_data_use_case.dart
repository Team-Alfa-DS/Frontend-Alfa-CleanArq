import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';

class GetNotificationDataUseCaseInput extends IUseCaseInput {
  GetNotificationDataUseCaseInput();
}

class GetNotificationDataUseCase {
class GetNotificationDataUseCase {
  final NotificationRepository _notificationRepository;

  GetNotificationDataUseCase(
      {required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;

  Future<Result<List<Notifications>>> execute(
      GetNotificationDataUseCaseInput input) {
    return _notificationRepository.getNotificationMany();
  }
}
