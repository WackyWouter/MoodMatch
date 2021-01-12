import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/status_api_response.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:moodmatch/widgets/notification_button.dart';
import 'package:moodmatch/widgets/small_icon_button.dart';
import 'package:moodmatch/screens/history_screen.dart';
import 'package:moodmatch/screens/settings_screen.dart';
import 'package:moodmatch/widgets/status_widget.dart';
import 'package:moodmatch/api.dart';
import 'package:moodmatch/widgets/flushbar_wrapper.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int youMood = 0;
  int partnerMood = 0;
  bool error = false;

  @override
  void initState() {
    super.initState();
    // call getStatuses after build
    _getStatuses();
  }

  @override
  Widget build(BuildContext context) {
    _checkForError();
    return Scaffold(
      backgroundColor: kLightPurple,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallIconButton(
                  onTap: () {
                    Navigator.pushNamed(context, HistoryScreen.id);
                  },
                  image: AssetImage('lib/assets/images/history.png'),
                ),
                Hero(
                  tag: 'appName',
                  child: GradientText(
                    kAppName,
                    kAppNameStyle.copyWith(fontSize: 40),
                  ),
                ),
                SmallIconButton(
                  onTap: () {
                    Navigator.pushNamed(context, SettingsScreen.id);
                  },
                  image: AssetImage('lib/assets/images/settings.png'),
                ),
              ],
            ),
            Container(
              width: 350,
              height: 100,
              decoration: BoxDecoration(
                  color: kDarkPurple,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatusWidget(title: 'You', inTheMood: youMood),
                      StatusWidget(title: 'Partner', inTheMood: partnerMood),
                    ],
                  ),
                ),
              ),
            ),
            NotificationButton(
              onTap: () {},
              image: AssetImage('lib/assets/images/snowflake.png'),
            ),
            NotificationButton(
              onTap: () {},
              image: AssetImage('lib/assets/images/fire_gradient.png'),
            )
          ],
        ),
      ),
    );
  }

  void _getStatuses() async {
    //TODO get matchid and matcheruuid from sharedpref
    int matchId = 11;
    String matcherUuid = '9c7aa3a1-a5dc-4cea-8ffd-abcf235913b8';

    StatusApiResponse status = await Api.getStatus(matchId, matcherUuid);
    if (status == null) {
      error = true;
    } else {
      // update mood
      setState(() {
        youMood = status.you;
        partnerMood = status.partner;
      });
    }
  }

  void _checkForError() {
    Timer(Duration(seconds: 2), () {
      if (error) {
        FlushbarWrapper().flushBarWrapper(
            messageText:
                Api.latestError ?? 'An error occurred. Please try agian later.',
            context: context,
            icon: Icon(
              Icons.error_outline,
              color: kError,
            ),
            leftBarIndicatorColor: kError);
      }
    });
  }
}
