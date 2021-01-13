import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/models/match_api_response.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:moodmatch/widgets/small_icon_button.dart';
import 'package:moodmatch/widgets/setting_btn.dart';
import 'package:moodmatch/api.dart';
import 'package:flutter/services.dart';
import 'package:moodmatch/widgets/flushbar_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String matcherUuid = '';
  int matchId = 0;
  bool matched = false;
  dynamic error;
  final myController = TextEditingController();

  @override
  void initState() {
    _getMatch();
    super.initState();
    // call getStatuses after build
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    "Settings",
                    kAppNameStyle.copyWith(fontSize: 40),
                  ),
                ),
                SizedBox(width: 50, height: 50)
              ],
            ),
            SizedBox(height: 30),
            Container(
              width: 350,
              height: 170,
              decoration: BoxDecoration(
                  color: kDarkPurple,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MATCH-CODE:',
                        style: kNormalTextStyle.copyWith(fontSize: 22)),
                    SizedBox(height: 5),
                    Text(
                      matcherUuid.length > 0
                          ? matcherUuid
                          : 'Error. Please try again later.',
                      style: kNormalTextStyle,
                    ),
                    SizedBox(height: 20),
                    Text('CONNECTED TO A PARTNER:',
                        style: kNormalTextStyle.copyWith(fontSize: 22)),
                    SizedBox(height: 5),
                    Text(
                      matched ? 'YES' : 'NO',
                      style: kNormalTextStyle,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SettingBtn(
                onTap: () {
                  // Add matcherUuid to the clipboard
                  Clipboard.setData(ClipboardData(text: matcherUuid));

                  // Show snackbar to let user now it has been added to the clipboard
                  FlushbarWrapper().flushBarWrapper(
                      messageText:
                          'Your Match-Code has been copied to the clipboard.',
                      context: context,
                      onPressed: () {
                        // Empty clipboard
                        Clipboard.setData(ClipboardData(text: ' '));
                      },
                      btnText: 'UNDO');
                },
                icon: 'lib/assets/images/copy.png',
                text: 'COPY MATCH CODE'),
            SizedBox(height: 10),
            SettingBtn(
                onTap: () {
                  if (matched) {
                    // Show popup to be sure to change match
                    _showConfirmationDialog();
                  } else {
                    // Show input popup
                    _showInputDialog();
                  }
                },
                icon: 'lib/assets/images/edit.png',
                text: 'NEW PARTNER'),
          ],
        ),
      ),
    );
  }

  void _getMatch() async {
    // get match_id and matcher_uuid from shared preff
    SharedPreferences prefs = await SharedPreferences.getInstance();
    matchId = prefs.getInt('matchId') ?? 0;
    matcherUuid = prefs.getString('matcherUuid') ?? '';
    matchId = 0;
    if (matchId > 0) {
      matched = true;
    }
  }

  void _showConfirmationDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext contextCD) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: kLightPurple,
          title: Text(
            "Change partner?",
            style: kNormalTextStyle.copyWith(fontSize: 20),
          ),
          content: Text(
              "Are you sure you want to match with a new partner? This will remove your current partner.",
              style: kNormalTextStyle),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Cancel",
                  style: kNormalTextStyle.copyWith(color: kPurple)),
              onPressed: () {
                Navigator.of(contextCD).pop();
              },
            ),
            FlatButton(
              child: Text("I'm sure!",
                  style: kNormalTextStyle.copyWith(color: kPurple)),
              onPressed: () {
                Navigator.of(contextCD).pop();
                _showInputDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInputDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext contextID) {
        // return object of type Dialog
        // Use stateful builder to be able to use setstate and only refresh the alertdialog
        return StatefulBuilder(builder: (contextID2, setStateID2) {
          return AlertDialog(
            backgroundColor: kLightPurple,
            title: Text(
              "Enter Match-code",
              style: kNormalTextStyle.copyWith(fontSize: 20),
            ),
            content: Container(
              width: 300,
              height: 100,
              child: Column(
                children: [
                  TextField(
                      controller: myController,
                      decoration:
                          kTextFieldDecoration.copyWith(errorText: error)),
                ],
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("Cancel",
                    style: kNormalTextStyle.copyWith(color: kPurple)),
                onPressed: () {
                  Navigator.of(contextID).pop();
                },
              ),
              FlatButton(
                child: Text("Submit",
                    style: kNormalTextStyle.copyWith(color: kPurple)),
                onPressed: () async {
                  // check input is not empty
                  if (myController.text.isNotEmpty) {
                    MatchApiResponse match = await Api.changePartner(
                        myController.text, matcherUuid, matched);
                    // check if call went wrong
                    if (match == null) {
                      setStateID2(() {
                        error = Api.latestError;
                      });
                    } else {
                      // update matched var and clean the error var
                      // Do this in two different set states bcs of different scopes
                      setStateID2(() {
                        error = null;
                      });
                      setState(() {
                        matched = true;
                      });
                      // close the popup
                      Navigator.of(contextID).pop();
                      // save match id in shared preference
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setInt('matchId', match.matchId);
                      // show flushbar to let user know of success
                      FlushbarWrapper().flushBarWrapper(
                        messageText: 'You have been successfully Partnered up!',
                        context: context,
                      );
                    }
                  } else {
                    setStateID2(() {
                      error = 'Please fill in the textfield.';
                    });
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }
}
