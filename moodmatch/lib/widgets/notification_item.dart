import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class NotificationItem extends StatelessWidget {
  final bool isme;
  final int mood;
  final String date;
  final String previousDate;

//  https://stackoverflow.com/questions/63813896/how-to-make-container-widget-take-only-the-required-space-in-flutter
// TODO fix only needed width
//  TODO add time in bottom corner
//  TODO add dates in between messages
  NotificationItem(
      {@required this.isme, @required this.date, @required this.mood, @required this.previousDate});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        CrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          date != previousDate ? Text(date, style:kNormalTextStyle) : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(
                alignment: isme ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .85),
                  decoration: BoxDecoration(
                      color: kDarkPurple,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          isme ? 0 : 10,
                        ),
                        topLeft: Radius.circular(
                          isme ? 10 : 0,
                        ),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment:
                          isme ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: isme
                          ? [
                              Image(
                                image: AssetImage(mood == 1
                                    ? 'lib/assets/images/fire_gradient.png'
                                    : 'lib/assets/images/snowflake.png'),
                                height: 35,
                                width: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                mood == 1
                                    ? 'YOU ARE IN THE MOOD'
                                    : 'YOU ARE NOT IN THE MOOD',
                                style: kNormalTextStyle,
                              )
                            ]
                          : [
                              Text(
                                mood == 1
                                    ? 'YOUR PARTNER IS IN THE MOOD'
                                    : 'YOUR PARTNER IS NOT IN THE MOOD',
                                style: kNormalTextStyle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image(
                                image: AssetImage(mood == 1
                                    ? 'lib/assets/images/fire_gradient.png'
                                    : 'lib/assets/images/snowflake.png'),
                                height: 35,
                                width: 35,
                              )
                            ],
                    ),
                  ),
                )),
          )
        ]
      )
    );
  }
}
