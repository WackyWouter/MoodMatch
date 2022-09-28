import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moodmatch/api.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/check_match_api_response.dart';
import 'package:moodmatch/models/device_id_api_response.dart';
import 'package:moodmatch/models/status_api_response.dart';
import 'package:moodmatch/screens/history_screen.dart';
import 'package:moodmatch/screens/settings_screen.dart';
import 'package:moodmatch/widgets/alert_dialog_wrapper.dart';
import 'package:moodmatch/widgets/flushbar_wrapper.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:moodmatch/widgets/notification_button.dart';
import 'package:moodmatch/widgets/small_icon_button.dart';
import 'package:moodmatch/widgets/status_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int youMood = 2;
  int partnerMood = 2;
  bool error = false;

  @override
  void initState() {
    super.initState();
    // call getStatuses after build
    _setup();
    // make a check if user got matched with if matched get current status
    checkifMatched();
  }

  @override
  Widget build(BuildContext context) {
    _checkForError();
    return Scaffold(
      backgroundColor: kLightPurple,
      body: SafeArea(
        child: Container(
          padding: new EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmallIconButton(
                    onTap: () {
                      Navigator.pushNamed(context, HistoryScreen.id)
                          .then((value) {
                        // make a check if user got matched with if matched get current status
                        checkifMatched();
                      });
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
                      Navigator.pushNamed(context, SettingsScreen.id)
                          .then((value) {
                        // make a check if user got matched with if matched get current status
                        checkifMatched();
                      });
                    },
                    image: AssetImage('lib/assets/images/settings.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(),
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
//                      TODO make this container swippable so that you can swipe through multiple partners if you have multiple partners
                        StatusWidget(title: 'You', inTheMood: youMood),
                        StatusWidget(title: 'Partner', inTheMood: partnerMood),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NotificationButton(
                        onTap: () {
                          handlePushNotificationBtn(0);
                        },
                        image: AssetImage('lib/assets/images/snowflake.png'),
                      ),
                      NotificationButton(
                        onTap: () {
                          handlePushNotificationBtn(1);
                        },
                        image:
                            AssetImage('lib/assets/images/fire_gradient.png'),
                      )
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _setup() async {
    // get matchid and matcheruuid from sharedpref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int matchId = prefs.getInt('matchId');
    String matcherUuid = prefs.getString('matcherUuid');

    if (matchId > 0) {
      StatusApiResponse status = await Api.getStatus(matchId, matcherUuid);

      if (status == null) {
        error = true;
      } else {
        error = false;
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
            messageText: Api.latestError ?? kDefaultError, context: context);
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
                "With this app you are able to notify your partner that you are in the mood. The snowflake means not in the mood and the flame means in the mood. If you click the top left icon you can see you and your partner\'s history. If you click on the top right you can match up with your partner. Do you wish to match up with your partner right now?",
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

  void handlePushNotificationBtn(int mood) async {
    // check if user is matched
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int matchId = prefs.getInt('matchId');
    String matcherUuid = prefs.getString('matcherUuid');

    if (!(matchId > 0)) {
      FlushbarWrapper().flushBarErrorWrapper(
          messageText:
              'You first need to be matched with your partner before you are able to send notifications',
          context: context);
      return;
    }

    // get device id from partner
    DeviceIdApiResponse deviceIdApiResponse =
        await Api.getPartnerDeviceId(matcherUuid, matchId);
    if (deviceIdApiResponse == null) {
      FlushbarWrapper().flushBarErrorWrapper(
          messageText: Api.latestError ?? kDefaultError, context: context);
      return;
    }
    error = false;
    String deviceId = deviceIdApiResponse.deviceId;

    // // Send the notification to FCM
    // FcmResponse fcmResponse =
    //     await PushNotificationSend().createNotification(mood, deviceId);
    // if (fcmResponse == null) {
    //   FlushbarWrapper().flushBarErrorWrapper(
    //       messageText: PushNotificationSend.latestError ?? kDefaultError,
    //       context: context);
    //   return;
    // }
    // if (fcmResponse.failure > 0) {
    //   FlushbarWrapper().flushBarErrorWrapper(
    //       messageText: fcmResponse.results.first.error ?? kDefaultError,
    //       context: context);
    //   return;
    // }

    setState(() {
      youMood = mood;
    });

    //  send note of push notification to DB
    bool success = await Api.addNotification(matcherUuid, matchId, mood);
    if (!success) {
      // FlushbarWrapper().flushBarErrorWrapper(
      //     messageText: fcmResponse.results.first.error ?? kDefaultError,
      //     context: context);
      return;
    }

    FlushbarWrapper().flushBarWrapper(
      messageText: 'The notification has been send succesfully!',
      context: context,
    );
  }

  void checkifMatched() async {
    // get matcheruuid from sharedpref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String matcherUuid = prefs.getString('matcherUuid');

    CheckMatchApiResponse matched = await Api.checkMatched(matcherUuid);

    if (matched != null) {
      error = false;
      if (matched.matched) {
        prefs.setInt('matchId', matched.matchId);
        getCurrentStatus();
        return;
      }
      // TODO show message that you have been unmatched
      prefs.setInt('matchId', 0);
      return;
    } else {
      error = true;
      FlushbarWrapper().flushBarErrorWrapper(
          messageText: Api.latestError ?? kDefaultError, context: context);
    }
  }

  void getCurrentStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String matcherUuid = prefs.getString('matcherUuid');
    int matchId = prefs.getInt('matchId');

    StatusApiResponse statusApiResponse =
        await Api.getStatus(matchId, matcherUuid);

    if (statusApiResponse != null) {
      setState(() {
        youMood = statusApiResponse.you;
        partnerMood = statusApiResponse.partner;
      });
      return;
    }

    FlushbarWrapper().flushBarErrorWrapper(
        messageText: Api.latestError ?? kDefaultError, context: context);
  }
}
