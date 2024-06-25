import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<Result<List<Notification>>> getManyNotification({
    required int page,
    required int perPage,
  });
  Future<Result<Notification>> getSingleNotification({required String id});
}
