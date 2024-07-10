import 'package:alpha_gymnastic_center/domain/entities/notification.dart';

class NotificationMapperMany {
  static Notifications fromJson(Map<String, dynamic> json) {
    try {
      return Notifications(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        date: DateTime.parse(json['date'] as String),
        userReaded: json['userReaded'] as bool? ?? false,
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
      'userReaded': notifications.userReaded,
    };
  }
}
