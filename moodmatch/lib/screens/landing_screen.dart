import 'package:flutter/material.dart';
import 'package:moodmatch/constant.dart';
import 'package:moodmatch/widgets/gradient_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:moodmatch/screens/home_screen.dart';
import 'dart:async';

class LandingScreen extends StatefulWidget {
  static const String id = 'landing_screen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _loading = true;

//  Push to home screen after delay
  void delay() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }

//  Make sure to check its mounted before attempting setstate
//  This is to prevent setstate being called after dispose
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLightPurple,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: _loading,
            opacity: 0,
            progressIndicator: SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: new AlwaysStoppedAnimation<Color>(kPurple),
              ),
            ),
            child: Container(
              child: Center(
                heightFactor: 2.5,
                child: Hero(
                  tag: 'appName',
                  child: GradientText(
                    kAppName,
                    kAppNameStyle.copyWith(fontSize: 70),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
