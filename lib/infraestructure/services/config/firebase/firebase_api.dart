import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/router.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Used for important Notif',
      importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print("Handling message: ${message.messageId}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Attempting to navigate to /notificationPush");
      final context = navigatorKey.currentContext;
      if (context != null) {
        GoRouter.of(context).push('/notificationPush', extra: message);
        print("Navigation attempted");
      } else {
        print("Context is null, unable to navigate");
      }
    });
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("Got initial message: ${message?.messageId}");
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen( (RemoteMessage message)
    {
       final notification = message.notification;
       if(notification != null){
            _localNotifications.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                    android: AndroidNotificationDetails(
                        _androidChannel.id,
                        _androidChannel.name,
                        channelDescription: _androidChannel.description,
                        icon: '@drawable/ic_launcher'
                    ),
                ),
              payload: jsonEncode(message.toMap()),
            );
       };
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Firebase Token: $fCMToken");
    await initPushNotifications();
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}