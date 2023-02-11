import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';

class SaltCombinedButton extends StatelessWidget {
  final String label;
  final String iconSrc;
  final VoidCallback callback;
  final double? width;
  final Color buttonColor, textButton;

  const SaltCombinedButton({
    Key? key,
    required this.label,
    required this.iconSrc,
    required this.callback,
    this.width,
    this.buttonColor = Colors.transparent,
    this.textButton = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final textSize = TextPainter(
      text: TextSpan(
        text: 'none',
        style: StyleConstants.kGetDefaultTextStyle(context).copyWith(
          fontSize: StyleConstants.kGetScreenRatio(context) ? 22.0 : 18.0,
          color: textButton,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return SizedBox(
      width: width ?? mq.size.width * 0.8,
      child: TextButton.icon(
        onPressed: callback,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const ContinuousRectangleBorder(),
          padding: EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: StyleConstants.kGetScreenRatio(context) ? 14.0 : 8.0,
          ),
        ),
        icon: Image.asset(
          iconSrc,
          height: textSize.height,
          width: textSize.height,
        ),
        label: Text(
          label,
          style: StyleConstants.kGetDefaultTextStyle(context).copyWith(
            fontSize: StyleConstants.kGetScreenRatio(context) ? 22.0 : 18.0,
            color: textButton,
          ),
        ),
      ),
    );
  }
}
