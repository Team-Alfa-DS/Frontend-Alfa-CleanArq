import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/repositories/notification_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/aplication/localStorage/local_storage.dart';
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
  Future<Result<List<Notifications>>> getNotificationMany({
    required int page,
    required int perPage,
  }) async {
    await _addAuthorizationHeader();
    try {
      final response = await _apiRequestManager.request(
        '/notification/many?page=$page&perpage=$perPage',
        'GET',
        (data) {
          List<Notifications> notifications = (data['notifications'] as List)
              .map((notificationData) =>
                  NotificationMapper.fromJson(notificationData))
              .toList();
          return notifications;
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
