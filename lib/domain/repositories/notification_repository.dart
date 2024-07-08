import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<Result<List<Notifications>>> getNotificationMany({
    required int page,
    required int perPage,
  });
  Future<Result<int>> getNotificationNotReaded();
  Future<Result<Notifications>> getSingleNotification({required String id});
  Future<Result<bool>> deleteNotifications();
}
