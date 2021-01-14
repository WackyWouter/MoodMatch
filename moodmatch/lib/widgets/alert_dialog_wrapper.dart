import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class AlertDialogWrapper extends StatelessWidget {
  final String title;
  final Widget content;
  final String btn1Text;
  final Function btn1OnPressed;
  final String btn2Text;
  final Function btn2OnPressed;

  AlertDialogWrapper(
      {@required this.title,
      @required this.content,
      @required this.btn1Text,
      @required this.btn1OnPressed,
      this.btn2OnPressed,
      this.btn2Text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kLightPurple,
      title: Text(
        title,
        style: kNormalTextStyle.copyWith(fontSize: 20),
      ),
      content: content,
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child:
              Text(btn1Text, style: kNormalTextStyle.copyWith(color: kPurple)),
          onPressed: btn1OnPressed,
        ),
        btn2Text != null && btn2OnPressed != null
            ? FlatButton(
                child: Text(btn2Text,
                    style: kNormalTextStyle.copyWith(color: kPurple)),
                onPressed: btn2OnPressed,
              )
            : SizedBox(),
      ],
    );
  }
}
