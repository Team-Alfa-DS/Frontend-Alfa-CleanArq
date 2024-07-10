import 'package:firebase_messaging/firebase_messaging.dart';

class PushNoti {
  initNotification() {
    final fcmToken = FirebaseMessaging.instance.getToken().then((token) {
      print('Token');
      print(token);
    });
  }
}
