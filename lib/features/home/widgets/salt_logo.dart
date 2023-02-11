import 'package:flutter/material.dart';

class SaltLogo extends StatelessWidget {
  const SaltLogo({Key? key}) : super(key: key);

  static getLogoSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.size.width * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/icon.png',
      height: getLogoSize(context),
    );
  }
}