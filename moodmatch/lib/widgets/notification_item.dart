import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/widgets/notification_item_text.dart';
import 'package:moodmatch/widgets/notification_item_image.dart';

class NotificationItem extends StatelessWidget {
  final bool isMe;
  final int mood;
  final String date;
  final String previousDate;
  final String time;

//  TODO add time in bottom corner
  NotificationItem(
      {@required this.isMe,
      @required this.date,
      @required this.mood,
      @required this.previousDate,
      @required this.time});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var maxContainerWidth = screenWidth * .90;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // check if the notification is on a new day compared to the previous notification
      date == previousDate
          ? SizedBox()
          : Padding(
              // do no top padding if its the first item
              padding: previousDate == ''
                  ? EdgeInsets.fromLTRB(8, 8, 8, 8)
                  : EdgeInsets.fromLTRB(8, 24, 8, 8),
              child: Text(date,
                  style: kNormalTextStyle.copyWith(color: kHintTextColor)),
            ),
      Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Align(
              // show messages to the right for the user and left for the partner
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                constraints: BoxConstraints(maxWidth: maxContainerWidth),
                decoration: BoxDecoration(
                    color: isMe ? kMeNotification : kDarkPurple,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        isMe ? 0 : 10,
                      ),
                      topLeft: Radius.circular(
                        isMe ? 10 : 0,
                      ),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: isMe
                            ? [
                                NotificationItemImage(mood: mood),
                                SizedBox(
                                  width: 10,
                                ),
                                NotificationItemText(
                                    maxContainerWidth: maxContainerWidth,
                                    mood: mood,
                                    isMe: isMe)
                              ]
                            : [
                                NotificationItemText(
                                    maxContainerWidth: maxContainerWidth,
                                    mood: mood,
                                    isMe: isMe),
                                SizedBox(
                                  width: 10,
                                ),
                                NotificationItemImage(mood: mood)
                              ],
                      ),
                      Text(time,
                          style: kNormalTextStyle.copyWith(
                              color: kHintTextColor, fontSize: 10))
                    ],
                  ),
                ),
              )),
        ),
      )
    ]);
  }
}
