import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:moodmatch/widgets/notification_button.dart';
import 'package:moodmatch/widgets/small_icon_button.dart';

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
                  onTap: () {},
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
                  onTap: () {},
                  image: AssetImage('lib/assets/images/settings.png'),
                ),
              ],
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
