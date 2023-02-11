import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class StyleConstants {
  static const kDefaultPadding = 10.0;
  static const kDefaultButtonSize = 60.0;

  static const kDefaultTransitionDuration = 1200;
  static const kBackgroundRotateDuration = 10000;

  static const Cubic kEaseInOutBackCustom = Cubic(0.68, -0.4, 0.265, 1.4);
  static const Cubic kEaseInOutCubicCustom = Curves.easeInOutCubic;
  static const Cubic kEaseInOutCustom = Curves.easeInOut;

  static TextStyle kGetDefaultTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: kGetScreenRatio(context) ? 18.0 : 14.0,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle kGetBoldTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: kGetScreenRatio(context) ? 18.0 : 14.0,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    );
  }

  static double kGetLargeTextSize(BuildContext context) {
    return kGetScreenRatio(context) ? 28.0 : 24.0;
  }

  static bool kGetScreenRatio(BuildContext context) {
    final mq = MediaQuery.of(context);
    const smallScreenSizeRatio = 1.75;
    return (mq.size.height / mq.size.width) > smallScreenSizeRatio;
  }

  static ui.ImageFilter kDefaultBlur =
      ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);

  static const kBackgroundColor = Color(0xFF141414);
  static const kHyperLinkColor = Colors.blueAccent;
  static const kSelectedColor = Colors.pink;
  static const kMarketColor = Colors.deepPurple;
  static const kInactiveColor = Colors.grey;

  static Color kGetLightColor() {
    return Colors.grey[50]!;
  }

  static Color kGetDarkColor() {
    return Colors.grey[850]!;
  }
}
