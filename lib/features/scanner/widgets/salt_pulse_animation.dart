import 'package:flutter/material.dart';

class SaltPulseAnimation extends StatelessWidget {
  const SaltPulseAnimation({Key? key}) : super(key: key);

  static getLogoSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.size.width * 0.75;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getLogoSize(context),
      child: Image.asset('assets/images/pulse.gif'),
    );
  }
}
