import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_boilerplate/utils/tools.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  /* 
  해당 함수는 isolated 가 되어야 한다. 다음 원칙이 지켜져야 함.
    1. 최상위 함수로 존재 (인스턴스의 메소드로 들어가면 안됨)
    2. onBackgroundMessage 콜백이 익명 함수로 들어갈 수 없음
  */
  logger.d('Received a notification');
}

class Notification {
  Notification._privateConstructor();
  static final Notification _instance = Notification._privateConstructor();

  factory Notification() {
    return _instance;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isInitializedReceiver = false;

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'artcalendar_channel',
    'Artcalendar Notifications',
    importance: Importance.max,
  );

  Future<void> addReceiver() async {
    await setUpNotification();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;

        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              ),
            ),
          );
        }
      },
    );

    isInitializedReceiver = true;
  }

  Future<void> setUpNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    InitializationSettings initializationSettings =
        const InitializationSettings(
      // 디폴트로 android/app/src/res/drawable 경로를 찾음 따로 지정, 아이콘 없으면 에러 발생
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<AuthorizationStatus> requestIOSPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus;
  }

  Future<bool> isNotification() async {
    if (Platform.isAndroid) {
      return true;
    }

    if (await requestIOSPermission() == AuthorizationStatus.authorized) {
      return true;
    }

    return false;
  }

  Future<String?> getToken() => FirebaseMessaging.instance.getToken();
}
