import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';


// create an instance

class NotificationService {


  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // channel id
    'High Importance Notifications', // channel name
    description:
        'This channel is used for important notifications.', // channel description
    importance: Importance.max,
  );


  bool _isMuted = false;



  void setupNotification() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus.name}');
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await messaging.getToken();
    print('FCM Token... $fcmToken');

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void showForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Handling a foreground message ${message.messageId}');
      print('Notification Message: ${message.data}');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        print('Message also contained a notification: $notification');
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                playSound: true,
                color: Colors.blue,
              ),
            ));
      } else {
        print('Notification is null');
      }
    });


    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
  }

  void showFGNotification(correctAnswers) {
    print('${!_isMuted} &&   ${_isNightTime()}');
    if (!_isMuted || !_isNightTime()) {
      flutterLocalNotificationsPlugin.show(
        0,
        "Quiz completed",
        "Source $correctAnswers",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }

  }

  bool _isNightTime() {
    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day, 23, 0); // 11 PM
    final endTime = DateTime(now.year, now.month, now.day, 6, 0); // 6 AM

    return now.isAfter(startTime) || now.isBefore(endTime);
  }

  void setNotificationMute(bool isMuted) {
    _isMuted = isMuted;
  }
}
