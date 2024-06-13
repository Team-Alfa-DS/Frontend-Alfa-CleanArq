import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/notification_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<Result<Notification>> createNotification(
      CreateNotificationRequest notificationRequest);
  Future<Result<List<Notification>>> getNotification({
    required String notificationId,
  });
}
