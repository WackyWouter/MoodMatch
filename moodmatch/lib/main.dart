import 'package:flutter/material.dart';
import 'package:moodmatch/screens/history_screen.dart';
import 'package:moodmatch/screens/home_screen.dart';
import 'package:moodmatch/screens/landing_screen.dart';
import 'package:moodmatch/screens/settings_screen.dart';

void main() {
  runApp(MoodMatch());
}

class MoodMatch extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
