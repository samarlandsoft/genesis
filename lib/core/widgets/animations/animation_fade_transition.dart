import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';

class AnimationFadeTransition extends StatefulWidget {
  final int duration;
  final Curve curve;
  final double opacity;
  final bool isActive;
  final Widget child;

  const AnimationFadeTransition({
    Key? key,
    this.duration = StyleConstants.kDefaultTransitionDuration,
    this.curve = StyleConstants.kEaseInOutBackCustom,
    required this.opacity,
    required this.isActive,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimationFadeTransition> createState() =>
      _AnimationFadeTransitionState();
}

class _AnimationFadeTransitionState extends State<AnimationFadeTransition> {
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
        return AnimatedOpacity(
          duration: Duration(milliseconds: widget.duration),
          curve: widget.curve,
          opacity: _isInit && widget.isActive ? widget.opacity : 0.0,
          child: widget.child,
        );
      },
    );
  }
}
