import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class SettingBtn extends StatelessWidget {
  final Function onTap;
  final String icon;
  final String text;

  SettingBtn({this.icon, @required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        decoration: BoxDecoration(
            color: kDarkPurple,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              icon != null
                  ? Image(
                      image: AssetImage(icon),
                      height: 30,
                      width: 30,
                    )
                  : SizedBox(),
              SizedBox(width: 10),
              Text(text, style: kNormalTextStyle.copyWith(fontSize: 22))
            ],
          ),
        ),
      ),
    );
  }
}
