import 'package:flutter/material.dart';
import 'package:moodmatch/screens/history_screen.dart';
import 'package:moodmatch/screens/home_screen.dart';
import 'package:moodmatch/screens/landing_screen.dart';
import 'package:moodmatch/screens/settings_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moodmatch/push_notifications/push_notification_service.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MoodMatch());
}

class MoodMatch extends StatelessWidget {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static const MethodChannel _channel =
      MethodChannel('moodnotifications.com/channel_test');
  static const Map<String, String> channelMap = {
    "id": "MOOD_MESSAGES",
    "name": "Mood",
    "description": "Notifications about your partners mood.",
    "soundname": "up"
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);

    _createNewChannel();
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

  void _createNewChannel() async {
//    https://rechor.medium.com/creating-notification-channels-in-flutter-android-e81e26b33bec
    try {
      await _channel.invokeMethod('createNotificationChannel', channelMap);
    } catch (e) {
      print(e);
    }
  }
}
