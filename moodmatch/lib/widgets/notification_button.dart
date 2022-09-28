import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class NotificationButton extends StatelessWidget {
  final Function onTap;
  final AssetImage image;

  NotificationButton({@required this.onTap, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
                color: kDarkPurple,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(image: image),
            )),
          ),
        ),
      ),
    );
  }
}
