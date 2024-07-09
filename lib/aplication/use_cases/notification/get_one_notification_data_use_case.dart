import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';

class GetSingleNotificationUseCaseInput extends IUseCaseInput {
  final String notificationId;

  GetSingleNotificationUseCaseInput({required this.notificationId});
}

class GetSingleNotificationUseCase
    implements IUseCase<GetSingleNotificationUseCaseInput, Notifications> {
  final NotificationRepository notificationRepository;

  GetSingleNotificationUseCase({required this.notificationRepository});

  @override
  Future<Result<Notifications>> execute(
      GetSingleNotificationUseCaseInput params) async {
    final result = await notificationRepository.getSingleNotification(
        id: params.notificationId);
    print("Result usecase");
    print(result.value);
    if (result.hasValue()) {
      final notification = result.value!;
      print('Course ID: ${notification.id}');
      print('Course Title : ${notification.title}');
    }
    return result;
  }
}
