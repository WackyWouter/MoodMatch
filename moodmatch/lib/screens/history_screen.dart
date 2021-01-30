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
                  SizedBox(width: 50, height: 50),
                  Hero(
                    tag: 'appName',
                    child: GradientText(
                      "History",
                      kAppNameStyle.copyWith(fontSize: 40),
                    ),
                  ),
                  SmallIconButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    image: AssetImage('lib/assets/images/backmirrored.png'),
                  )
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                    child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: kPurple,
                    child:
                        notificationList != null && notificationList.length > 0
                            ? ListView.builder(
                                padding: const EdgeInsets.only(bottom: 8),
                                itemBuilder: (context, index) {
                                  NotificationHistory notification =
                                      notificationList[index];
                                  return NotificationItem(
                                    isMe: notification.user == matcherUuid,
                                    mood: notification.mood,
                                    date: notification.date,
                                    previousDate: index != 0
                                        ? notificationList[index - 1].date
                                        : '',
                                    time: notification.time,
                                  );
                                },
                                itemCount: notificationList.length,
                              )
                            : Center(
                                heightFactor: 0.5,
                                child: Text(
                                  message,
                                  style: kNormalTextStyle,
                                )),
                  ),
                )),
              )
            ],
          ),
        ));
  }

  _getHistory() async {
    // get match_id and matcher_uuid from shared preff
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      matchId = prefs.getInt('matchId');
      matcherUuid = prefs.getString('matcherUuid');
    });

    // if user is matched get history
    if (matchId > 0) {
      HistoryApiResponse history = await Api.getHistory(matcherUuid, matchId);
      // set error = true if it went wrong
      if (history == null) {
        setState(() {
          error = true;
        });
      } else {
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
            messageText: Api.latestError ?? kDefaultError, context: context);
      }
    });
  }
}
