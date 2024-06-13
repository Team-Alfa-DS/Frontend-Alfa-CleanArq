import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';

class GetNotificationDataUseCaseInput extends IUseCaseInput {
  final String notificationId;

  GetNotificationDataUseCaseInput({required this.notificationId});
}

class GetNotificationDataUseCase
    implements IUseCase<GetNotificationDataUseCaseInput, List<Notification>> {
  final NotificationRepository _notificationRepository;

  GetNotificationDataUseCase(this._notificationRepository);

  @override
  Future<Result<List<Notification>>> execute(
      GetNotificationDataUseCaseInput params) async {
    return await _notificationRepository.getNotification(
        notificationId: params.notificationId);
  }
}
