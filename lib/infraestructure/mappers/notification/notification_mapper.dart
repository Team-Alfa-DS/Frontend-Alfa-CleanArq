import 'package:alpha_gymnastic_center/domain/entities/notification.dart';

class NotificationMapper {
  static Notification fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      date: DateTime.parse(json['date']),
      userReaded: json['userReaded'],
    );
  }

  static Map<String, dynamic> toJson(Notification notification) {
    return {
      'id': notification.id,
      'title': notification.title,
      'body': notification.body,
      'date': notification.date.toIso8601String(),
      'userReaded': notification.userReaded,
    };
  }
}
