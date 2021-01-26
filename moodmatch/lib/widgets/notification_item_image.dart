import 'package:flutter/material.dart';

class NotificationItemImage extends StatelessWidget {
  final int mood;

  NotificationItemImage({@required this.mood});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(mood == 1
          ? 'lib/assets/images/fire_gradient.png'
          : 'lib/assets/images/snowflake.png'),
      height: 35,
      width: 35,
    );
  }
}
