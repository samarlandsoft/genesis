import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';

class AnimationScaleTransition extends StatefulWidget {
  final int duration;
  final Curve curve;
  final double scale;
  final bool isActive;
  final Widget child;

  const AnimationScaleTransition({
    Key? key,
    this.duration = StyleConstants.kDefaultTransitionDuration,
    this.curve = StyleConstants.kEaseInOutBackCustom,
    required this.scale,
    required this.isActive,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimationScaleTransition> createState() =>
      _AnimationScaleTransitionState();
}

class _AnimationScaleTransitionState extends State<AnimationScaleTransition> {
  bool _isInit = false;

  void _startAnimationCallback() {
    if (!_isInit) {
      setState(() {
        _isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration.zero).then((_) => _startAnimationCallback()),
      builder: (context, _) {
        return AnimatedScale(
          duration: Duration(milliseconds: widget.duration),
          curve: widget.curve,
          scale: _isInit && widget.isActive ? widget.scale : 0.5,
          child: widget.child,
        );
      },
    );
  }
}
