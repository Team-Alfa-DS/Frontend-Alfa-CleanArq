import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/notification_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/notification/notification_mapper.dart';
import '../../../common/result.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final IApiRequestManager _apiRequestManager;

  NotificationRepositoryImpl({required IApiRequestManager apiRequestManager})
      : _apiRequestManager = apiRequestManager;

  @override
  Future<Result<Notification>> createNotification(
      CreateNotificationRequest notificationRequest) async {
    final response = await _apiRequestManager.request(
      '/notification',
      'POST',
      (data) => NotificationMapper.fromJson(data),
      body: NotificationMapper.toJson(
        Notification(
          id: '',
          date: notificationRequest.date,
          title: notificationRequest.title,
          body: notificationRequest.body,
          userReaded: notificationRequest.userReaded,
        ),
      ),
    );

    return response;
  }

  @override
  Future<Result<List<Notification>>> getNotification(
      {required String notificationId}) async {
    final response = await _apiRequestManager.request(
      '/notification',
      'GET',
      (data) => (data as List)
          .map((notificationData) =>
              NotificationMapper.fromJson(notificationData))
          .toList(),
    );

    return response;
  }
}
