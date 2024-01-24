import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_playground/customWidgets/CustomButton.dart';
import 'package:flutter_playground/customWidgets/styledText.dart';
import 'package:flutter_playground/data/questions.dart';
import 'package:flutter_playground/quizWidgets/quiz.dart';
import 'package:flutter_playground/quizWidgets/result_Summary.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.selectedAnswers});
  final List<String> selectedAnswers;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // final AndroidNotificationChannel notificationChannel =
  //     const AndroidNotificationChannel(
  //   'first_channel',
  //   'First Channel',
  //   description: 'This is the first notification channel',
  //   importance: Importance.high,
  //   playSound: true,
  // );

  void setupNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    await fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await fcm.getToken();
    print('FCM Token... $fcmToken');

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<    
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void showForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     const NotificationDetails(
      //       android: AndroidNotificationDetails(
      //         'first_channel',
      //         'First Channel',
      //       ),
      //     ),
      //   );
      // }
      if (notification != null && android != null) {
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
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupNotification();
    showForegroundNotification();
  }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < widget.selectedAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].question,
          'correct_answer': questions[i].answers[0],
          'user_answer': widget.selectedAnswers[i]
        },
      );
    }
    return summary;
  }

  @override
  Widget build(context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData()
        .where((data) => data['user_answer'] == data['correct_answer'])
        .toList()
        .length;
    void showNotification() {
      // setState(() {
      //   _counter++;
      // });
      flutterLocalNotificationsPlugin.show(
          0,
          "Testing $numCorrectQuestions",
          "How you doin ?",
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  importance: Importance.high,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher')));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 14, 128),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            StyledText(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly',
              textSize: 22,
              textColor: Colors.white,
              textWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ResultSummary(getSummaryData()),
            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.all(20),
            //     itemCount: selectedAnswers.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [
            //           Text(
            //             questions[index].question,
            //             textAlign: TextAlign.left,
            //             style: const TextStyle(
            //                 fontSize: 18,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w600),
            //           ),
            //           Text(
            //             selectedAnswers[index],
            //             textAlign: TextAlign.left,
            //             style: const TextStyle(
            //                 fontSize: 18,
            //                 color: Color.fromARGB(255, 0, 255, 229),
            //                 fontWeight: FontWeight.w500),
            //           ),
            //           Text(
            //             questions[index].answers[0],
            //             textAlign: TextAlign.left,
            //             style: const TextStyle(
            //                 fontSize: 18,
            //                 color: Color.fromARGB(255, 0, 255, 229),
            //                 fontWeight: FontWeight.w500),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(height: 40),
            CustomButton(
              bgColor: const Color.fromARGB(97, 94, 11, 109),
              onPressed: () {
                showNotification;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Quiz(),
                  ),
                );
              },
              buttonText: 'Restart Quiz',
              buttonIcon: Icons.refresh,
            )
          ],
        ),
      ),
    );
  }
}
