import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text,
    this.textStyle,
  );

  final String text;
  final TextStyle textStyle;
  final Gradient gradient = LinearGradient(
    colors: [kPurple, kPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
//    Force the text style color to always be white
      child: Text(
        text,
        style: textStyle != null
            ? textStyle.copyWith(
                color: Colors.white,
              )
            : TextStyle(
                // The color must be set to white for this to work
                color: Colors.white,
                fontSize: 40,
              ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
