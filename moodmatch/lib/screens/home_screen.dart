import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:moodmatch/widgets/notification_button.dart';
import 'package:moodmatch/widgets/small_icon_button.dart';
import 'package:moodmatch/screens/history_screen.dart';
import 'package:moodmatch/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'YOU',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'RobotoLocal',
                              fontWeight: FontWeight.bold,
                              color: kNonGradientText),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'lib/assets/images/snowflakegrey.png'),
                              height: 35,
                              width: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image:
                                  AssetImage('lib/assets/images/firegrey.png'),
                              height: 35,
                              width: 35,
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'PARTNER',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'RobotoLocal',
                              fontWeight: FontWeight.bold,
                              color: kNonGradientText),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'lib/assets/images/snowflakegrey.png'),
                              height: 35,
                              width: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image:
                                  AssetImage('lib/assets/images/firegrey.png'),
                              height: 35,
                              width: 35,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )),
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
}
