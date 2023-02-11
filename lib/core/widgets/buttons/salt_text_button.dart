import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/widgets/salt_animated_loader.dart';

class SaltTextButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final double? width;
  final Color buttonColor, textButton;
  final bool isLoading;

  const SaltTextButton({
    Key? key,
    required this.label,
    required this.callback,
    this.width,
    this.buttonColor = Colors.black,
    this.textButton = Colors.white,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);
    final double buttonSize = isLargeScreen
        ? StyleConstants.kDefaultButtonSize
        : StyleConstants.kDefaultButtonSize * 0.8;
    final double iconSize = isLargeScreen
        ? StyleConstants.kDefaultButtonSize * 0.8
        : StyleConstants.kDefaultButtonSize * 0.6;

    final textSize = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: 18.0,
          color: textButton,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return SizedBox(
      width: width ?? mq.size.width * 0.8,
      child: TextButton(
        onPressed: callback,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const ContinuousRectangleBorder(),
          padding: EdgeInsets.symmetric(
            vertical: isLoading
                ? (buttonSize - iconSize) * 0.5
                : (buttonSize - textSize.height) * 0.5,
            horizontal: 10.0,
          ),
        ),
        child: isLoading
            ? SaltAnimatedLoader(size: iconSize + 1.0)
            : Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  color: textButton,
                ),
              ),
      ),
    );
  }
}
