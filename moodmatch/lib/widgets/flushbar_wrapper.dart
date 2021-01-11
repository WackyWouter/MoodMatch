import 'package:moodmatch/constant.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class FlushbarWrapper {
  void flushBarWrapper(
      {Function onPressed,
      Icon icon,
      String btnText,
      int duration = 3,
      bool isDismissible = true,
      Color leftBarIndicatorColor = kPurple,
      @required String messageText,
      @required BuildContext context}) {
    Flushbar(
      icon: icon != null ? icon : null,
      borderRadius: 10,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      shouldIconPulse: false,
      isDismissible: isDismissible,
      backgroundColor: kDarkPurple,
      leftBarIndicatorColor: leftBarIndicatorColor,
      mainButton: btnText != null
          ? FlatButton(
              onPressed: onPressed ?? () {},
              child: Text(
                btnText,
                style: TextStyle(color: kPurple),
              ),
            )
          : null,
      messageText:
          Text(messageText, style: kNormalTextStyle.copyWith(fontSize: 16)),
      duration: Duration(seconds: duration),
    )..show(context);
  }
}
