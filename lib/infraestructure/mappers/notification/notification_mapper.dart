import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/notification_interfaces.dart';

class NotificationMapper {
  static Notifications fromJson(Map<String, dynamic> json) {
    try {
      return Notifications(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        date: DateTime.parse(json['date'] as String),
      );
    } catch (e) {
      print('Error in NotificationMapper.fromJson: $e');
      rethrow;
    }
  }

  static Map<String, dynamic> toJson(Notifications notifications) {
    return {
      'id': notifications.id,
      'title': notifications.title,
      'body': notifications.body,
      'date': notifications.date.toIso8601String(),
    };
  }
}
