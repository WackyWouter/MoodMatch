import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text,
    this.textStyle, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;
  final TextStyle textStyle;

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
            ? textStyle.copyWith(color: Colors.white)
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
