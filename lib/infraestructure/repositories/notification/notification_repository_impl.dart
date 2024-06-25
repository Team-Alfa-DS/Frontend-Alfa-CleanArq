import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/notification/notification_mapper.dart';
import '../../../common/result.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  NotificationRepositoryImpl(
      {required IApiRequestManager apiRequestManager,
      required LocalStorage localStorage})
      : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<List<Notification>>> getManyNotification(
      {required int page, required int perPage}) async {
    await _addAuthorizationHeader();
    try {
      final token = await _localStorage.getAuthorizationToken();
      _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
      final response = await _apiRequestManager
          .request('/notifications/many', 'GET', (data) {
        List<Notification> notifications = data(['notifications' as List])
            .map((notifyData) => NotificationMapperMany.fromJson(notifyData))
            .toList();
        for (var notification in notifications) {}
        return notifications;
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Result<Notification>> getSingleNotification(
      {required String id}) async {
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    final response = await _apiRequestManager
        .request<Notification>('/notification/one/$id', 'GET', (data) {
      return NotificationMapperOne.fromJson(data);
    });
    if (response.hasValue()) {
      final notification = response.value!;
    }
    return response;
  }
}
