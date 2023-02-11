import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';

class AnimationPositionTransition extends StatelessWidget {
  final int duration;
  final Curve curve;
  final double? upperBoundValue;
  final double? lowerBoundValue;
  final double? height;
  final Widget child;

  const AnimationPositionTransition({
    Key? key,
    this.duration = StyleConstants.kDefaultTransitionDuration,
    this.curve = StyleConstants.kEaseInOutBackCustom,
    this.upperBoundValue,
    this.lowerBoundValue,
    this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      curve: curve,
      top: upperBoundValue,
      bottom: lowerBoundValue,
      height: height,
      left: 0.0,
      right: 0.0,
      child: child,
    );
  }
}
