import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moodmatch/api.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/history_api_response.dart';
import 'package:moodmatch/models/notification_history.dart';
import 'package:moodmatch/widgets/flushbar_wrapper.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:moodmatch/widgets/notification_item.dart';
import 'package:moodmatch/widgets/small_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  static const String id = 'history_screen';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String matcherUuid = '';
  int matchId = 0;
  bool error = false;
  String message = 'No notifications found.';
  List<NotificationHistory> notificationList;

  @override
  void initState() {
    _getHistory();
    super.initState();
    // call getStatuses after build
  }

  @override
  Widget build(BuildContext context) {
    _checkForError();
    return Scaffold(
        backgroundColor: kLightPurple,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallIconButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    image: AssetImage('lib/assets/images/back.png'),
                  ),
                  Hero(
                    tag: 'appName',
                    child: GradientText(
                      "History",
                      kAppNameStyle.copyWith(fontSize: 40),
                    ),
                  ),
                  SizedBox(width: 50, height: 50)
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                    child:
                        notificationList != null && notificationList.length > 0
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  NotificationHistory notification =
                                      notificationList[index];
                                  return NotificationItem(
                                    isme: notification.user == matcherUuid,
                                    mood: notification.mood,
                                    date: notification.date,
                                  );
                                },
                                itemCount: notificationList.length,
                              )
                            : Center(
                                heightFactor: 0.5,
                                child: Text(
                                  message,
                                  style: kNormalTextStyle,
                                ))),
              )
            ],
          ),
        ));
  }

  _getHistory() async {
    // get match_id and matcher_uuid from shared preff
    SharedPreferences prefs = await SharedPreferences.getInstance();
    matchId = prefs.getInt('matchId') ?? 11;
    matcherUuid = prefs.getString('matcherUuid') ??
        '9c7aa3a1-a5dc-4cea-8ffd-abcf235913b8';
    // if user is matched get history
    if (matchId > 0) {
      print("matchid > 0");
      HistoryApiResponse history = await Api.getHistory(matcherUuid, matchId);

      // set error = true if it went wrong
      if (history == null) {
        setState(() {
          error = true;
        });
      } else {
        // TODO build notification list
        setState(() {
          notificationList = history.notificationList;
        });
      }
    } else {
      setState(() {
        message = "You have not yet registerd a partner.";
      });
    }
  }

  void _checkForError() {
    Timer(Duration(seconds: 2), () {
      if (error) {
        FlushbarWrapper().flushBarErrorWrapper(
            messageText:
                Api.latestError ?? 'An error occurred. Please try again later.',
            context: context);
      }
    });
  }
}
