import 'package:alpha_gymnastic_center/common/use_case.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';

class GetNotificationDataUseCaseInput extends IUseCaseInput {
  final int page;
  final int perPage;

  GetNotificationDataUseCaseInput({required this.page, required this.perPage});
}

class GetNotificationDataUseCase
    implements IUseCase<GetNotificationDataUseCaseInput, List<Notification>> {
  final NotificationRepository notificationRepository;

  GetNotificationDataUseCase({required this.notificationRepository});

  @override
  Future<Result<List<Notification>>> execute(
      GetNotificationDataUseCaseInput params) async {
    return await notificationRepository.getManyNotification(
        page: params.page, perPage: params.perPage);
  }
}
