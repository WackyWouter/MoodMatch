import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class NotificationButton extends StatelessWidget {
  final Function onTap;
  final AssetImage image;

  NotificationButton({@required this.onTap, @required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: kDarkPurple,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(image: image),
        )),
      ),
    );
  }
}
