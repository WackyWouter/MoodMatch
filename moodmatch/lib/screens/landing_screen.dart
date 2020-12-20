import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:gradient_progress/gradient_progress.dart';
import 'package:moodmatch/screens/home_screen.dart';
import 'dart:async';

class LandingScreen extends StatefulWidget {
  static const String id = 'landing_screen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void delay() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    });
  }

//  TODO make a better progress indicator that on finish will open next page
  @override
  Widget build(BuildContext context) {
    delay();
    return Scaffold(
        backgroundColor: kLightPurple,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//          add MoodMatch here in gradient text
              Container(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'appName',
                  child: GradientText(
                    kAppName,
                    kAppNameStyle.copyWith(fontSize: 70),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GradientCircularProgressIndicator(
                gradientColors: [kPurple, kPink],
                radius: 30,
                strokeWidth: 10.0,
                value: new Tween(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(
                        parent: _animationController, curve: Curves.decelerate))
                    .value,
              ),
              SizedBox(
                height: 200,
              ),
//          progress indicator
            ],
          ),
        ));
  }
}
