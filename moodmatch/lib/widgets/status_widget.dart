import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class StatusWidget extends StatelessWidget {
  final String title;
//  0 = nothing selected, 1 = horny, 2 = not horny
  final int inTheMood;

  StatusWidget({@required this.title, this.inTheMood});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title ?? '',
            style: kNormalTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Image(
              image: AssetImage(inTheMood == 2
                  ? 'lib/assets/images/snowflake.png'
                  : 'lib/assets/images/snowflakegrey.png'),
              height: 35,
              width: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Image(
              image: AssetImage(inTheMood == 1
                  ? 'lib/assets/images/fire_gradient.png'
                  : 'lib/assets/images/firegrey.png'),
              height: 35,
              width: 35,
            )
          ],
        )
      ],
    );
  }
}
