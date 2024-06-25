import 'package:alpha_gymnastic_center/domain/entities/notification.dart';
import 'package:alpha_gymnastic_center/domain/interfaces/notification_interfaces.dart';

class NotificationMapperMany {
  static Notification fromJson(Map<String, dynamic> json) {
    try {
      return Notification(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        date: DateTime.parse(json['date']),
        userReaded: json['userReaded'],
      );
    } catch (e) {
      print('Error in NotificationMapperMany.fromJson: $e');
      rethrow;
    }
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

class NotificationMapperOne {
  static Notification fromJson(Map<String, dynamic> json) {
    try {
      return Notification(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        date: DateTime.parse(json['date']),
      );
    } catch (e) {
      print('Error in NotificationMapperOne.fromJson: $e');
      rethrow;
    }
  }

  static Map<String, dynamic> toJson(CreateNotificationRequest createRequest) {
    return {
      'id': createRequest.id,
      'title': createRequest.title,
      'body': createRequest.body,
      'date': createRequest.date,
    };
  }
}
