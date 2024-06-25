import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';

class GetSingleNotificationUseCaseInput extends IUseCaseInput {
  final String notificationId;

  GetSingleNotificationUseCaseInput({required this.notificationId});
}

class GetSingleNotificationUseCase
    implements IUseCase<GetSingleNotificationUseCaseInput, Notification> {
  final NotificationRepository notificationRepository;

  GetSingleNotificationUseCase({required this.notificationRepository});

  @override
  Future<Result<Notification>> execute(
      GetSingleNotificationUseCaseInput params) async {
    final result = await notificationRepository.getSingleNotification(
        id: params.notificationId);
    if (result.hasValue()) {
      final course = result.value!;
      print('Course ID: ${course.id}');
      print('Course Title : ${course.title}');
    }
    return result;
  }
}
