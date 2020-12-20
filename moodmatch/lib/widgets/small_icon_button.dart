import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  final Function onTap;
  final AssetImage image;

  SmallIconButton({@required this.onTap, @required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image(
        image: image,
        height: 50,
        width: 50,
      ),
    );
  }
}
