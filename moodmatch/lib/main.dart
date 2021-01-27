import 'package:flutter/material.dart';
import 'package:moodmatch/screens/history_screen.dart';
import 'package:moodmatch/screens/home_screen.dart';
import 'package:moodmatch/screens/landing_screen.dart';
import 'package:moodmatch/screens/settings_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moodmatch/push_notifications/push_notification_service.dart';

void main() {
  runApp(MoodMatch());
}

class MoodMatch extends StatelessWidget {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();
    return MaterialApp(
      title: 'MoodMatch',
      initialRoute: LandingScreen.id,
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        HistoryScreen.id: (context) => HistoryScreen(),
      },
    );
  }
}
