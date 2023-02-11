import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;

  const ContentWrapper({
    Key? key,
    required this.widget,
  }) : super(key: key);

  static double getWrapperPadding(BuildContext context) {
    final mq = MediaQuery.of(context);
    return StyleConstants.kDefaultPadding + mq.size.width * 0.03;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWrapperPadding(context)),
      child: widget,
    );
  }
}
