import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/api_response.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moodmatch/widgets/alert_dialog_wrapper.dart';

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
    _setup();
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

  void _setup() async {
    // get matchid and matcheruuid from sharedpref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int matchId = prefs.getInt('matchId') ?? 0;
    String matcherUuid = prefs.getString('matcherUuid') ?? '';
    String deviceId = prefs.getString('deviceId') ?? '';

    // TODO check if the saved device id is the same as the one from firebase
    if (deviceId != 'TODO change this to firebase token') {
      // check if update deviceId went correctly
      bool success = await Api.updateDeviceId(deviceId);
      if (!success) {
        FlushbarWrapper().flushBarErrorWrapper(
            messageText:
                Api.latestError ?? 'An error occurred. Please try agian later.',
            context: context);
      }
    }

    matchId = 11;
    matcherUuid = '9c7aa3a1-a5dc-4cea-8ffd-abcf235913b8';

    if (matchId > 0) {
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
    } else {
      // show popup explaining how to match
      _showExplanationDialog();
    }
  }

  void _checkForError() {
    Timer(Duration(seconds: 2), () {
      if (error) {
        FlushbarWrapper().flushBarErrorWrapper(
            messageText:
                Api.latestError ?? 'An error occurred. Please try agian later.',
            context: context);
      }
    });
  }

  void _showExplanationDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext contextED) {
        // return object of type Dialog
        return AlertDialogWrapper(
            title: 'Explanation',
            content: Text(
                "With this app you're able to notify you're partner that you are in the mood. The snowflake means not in the mood and the flame means in the mood. If you click the top left icon you can see you and your partners history. If you click on the top right you can match up with your partner. Do you wish to match up with your partner right now?",
                style: kNormalTextStyle),
            btn1Text: 'Not right now',
            btn1OnPressed: () {
              Navigator.of(contextED).pop();
            },
            btn2Text: 'Yes',
            btn2OnPressed: () {
              Navigator.of(contextED).pop();
              Navigator.pushNamed(context, SettingsScreen.id);
            });
      },
    );
  }
}
