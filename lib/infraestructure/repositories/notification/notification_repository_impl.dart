import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/common/result.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/notification/notification_mapper.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  NotificationRepositoryImpl({
    required IApiRequestManager apiRequestManager,
    required LocalStorage localStorage,
  })  : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<List<Notifications>>> getNotificationMany() async {
    await _addAuthorizationHeader();
    try {
      final response = await _apiRequestManager.request(
        '/notify/all',
        'GET',
        (data) {
          List<Notifications> notifications = (data['notifications'] as List)
              .map((notificationData) =>
                  NotificationMapperMany.fromJson(notificationData))
              .toList();
          return notifications;
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Result<int>> getNotificationNotReaded() async {
    await _addAuthorizationHeader();
    try {
      final response = await _apiRequestManager.request(
        '/notify/count',
        'GET',
        (data) => data['count'] as int,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Result<Notifications>> getSingleNotification(
      {required String id}) async {
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    final response = await _apiRequestManager
        .request<Notifications>('/notify/one/$id', 'GET', (data) {
      print('Data received in getSingleNotification: $data');
      return NotificationMapperMany.fromJson(data);
    });
    if (response.hasValue()) {
      final notification = response.value!;
      print('Notification in getSingleNotification:');
      print(notification);
    }
    return response;
  }

  @override
  Future<Result<bool>> deleteNotifications() async {
    await _addAuthorizationHeader();
    try {
      final response = await _apiRequestManager.request(
        '/notify/delete',
        'DELETE',
        (data) => true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
