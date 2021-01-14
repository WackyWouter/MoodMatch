import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:moodmatch/api.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/history_api_response.dart';
import 'package:moodmatch/models/notification_history.dart';
import 'package:moodmatch/widgets/flushbar_wrapper.dart';
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
          child: Container(),
        ));
  }

  _getHistory() async {
    // get match_id and matcher_uuid from shared preff
    SharedPreferences prefs = await SharedPreferences.getInstance();
    matchId = prefs.getInt('matchId') ?? 0;
    matcherUuid = prefs.getString('matcherUuid') ?? '';

    // if user is matched get history
    if (matchId > 0) {
      HistoryApiResponse history = await Api.getHistory(matcherUuid, matchId);

      // set error = true if it went wrong
      if (history == null) {
        error = null;
      } else {
        // TODO build notification list
      }
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
}
