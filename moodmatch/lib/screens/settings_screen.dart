import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:moodmatch/widgets/small_icon_button.dart';
import 'package:flutter/services.dart';
import 'package:moodmatch/widgets/setting_btn.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String matcherUuid = '';
  int matchId = 0;
  bool matched = false;

  void getMatch() {
    // TODO get match_id and matcher_uuid from shared preff
    matcherUuid = 'TESTf6b8-2158-43a7-8c9c-d7a3e35d18b9';
    matchId = 0;
    if (matchId > 0) {
      matched = true;
    }
  }

  // TODO change this to a flush bar - https://pub.dev/packages/flushbar
  final snackBar = SnackBar(
    backgroundColor: kDarkPurple,
    content: Text('Copied to clipboard',
        style: kNormalTextStyle.copyWith(fontSize: 18)),
    action: SnackBarAction(
      label: 'undo',
      textColor: kPurple,
      onPressed: () {
        Clipboard.setData(ClipboardData(text: ''));
      },
    ),
  );

  @override
  void initState() {
    getMatch();
    super.initState();
    // call getStatuses after build
  }

  // TODO check if flush bar needs the builder context under body
  // Cause i think it can just use the context from the build widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightPurple,
      body: Builder(
        builder: (scaffoldContext) => SafeArea(
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
                      Text('MATCH-CODE:', style: kNormalTextStyle),
                      SizedBox(height: 5),
                      Text(
                        matcherUuid.length > 0
                            ? matcherUuid
                            : 'Error. Please try again later.',
                        style: kNormalTextStyle.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Text('CONNECTED TO A PARTNER:', style: kNormalTextStyle),
                      SizedBox(height: 5),
                      Text(
                        matched ? 'YES' : 'NO',
                        style: kNormalTextStyle.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SettingBtn(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: matcherUuid));

                    // show a SnackBar.
                    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
                  },
                  icon: 'lib/assets/images/copy.png',
                  text: 'COPY MATCH CODE'),
              SizedBox(height: 10),
              SettingBtn(
                  onTap: () {},
                  icon: 'lib/assets/images/edit.png',
                  text: 'NEW PARTNER'),
            ],
          ),
        ),
      ),
    );
  }
}
