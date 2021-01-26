import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class NotificationItemText extends StatelessWidget {
  final maxContainerWidth;
  final int mood;
  final bool isMe;

  NotificationItemText(
      {@required this.maxContainerWidth,
      @required this.mood,
      @required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          // max container with minus the image width + paddings
          maxWidth: maxContainerWidth - 90),
      child: Text(
        mood == 1
            ? (isMe ? 'YOU ARE IN THE MOOD' : 'YOUR PARTNER IS IN THE MOOD')
            : (isMe
                ? 'YOU ARE NOT IN THE MOOD'
                : 'YOUR PARTNER IS NOT IN THE MOOD'),
        textAlign: TextAlign.right,
        style: kNormalTextStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
