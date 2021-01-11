import 'package:flutter/material.dart';

const Color kLightPurple = Color(0xFF291F34);
const Color kDarkPurple = Color(0xFF160E1F);
const Color kNonGradientText = Color(0xFFFFFFFF);
const Color kInputTextColor = Colors.black;
const Color kPurple = Color(0xFF6337FF);
const Color kPink = Color(0xFFD751FF);
const Color kError = Color(0xFFe50000);
const String kAppName = 'MOOD\nMATCH';
const String kUrl = 'http://wfcbosch-nl.stackstaging.com/MoodMatch/index.php/';
const TextStyle kAppNameStyle = TextStyle(
  fontFamily: 'RobotoLocal',
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w900,
);
const TextStyle kNormalTextStyle = TextStyle(
  fontFamily: 'RobotoLocal',
  color: kNonGradientText,
  fontSize: 16,
);

InputDecoration kTextFieldDecoration = InputDecoration(
  errorMaxLines: 2,
  hintText: 'Fill in...',
  hintStyle: kNormalTextStyle.copyWith(color: kInputTextColor),
  errorStyle: kNormalTextStyle.copyWith(color: kError, fontSize: 14),
  filled: true,
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: BorderSide(color: kPurple, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: BorderSide(color: kError, width: 2),
  ),
  border: OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: BorderSide(color: kPurple, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: BorderSide(color: kPurple, width: 0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10.0),
    borderSide: BorderSide(color: kError, width: 2),
  ),
);
