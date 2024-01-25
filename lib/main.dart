import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_playground/utils/notification_service.dart';
import 'firebase_options.dart';
import 'package:flutter_playground/mainContainer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().setupNotification();
  runApp(const MainContainer());
}
