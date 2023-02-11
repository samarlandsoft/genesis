import 'dart:math' as math;
import 'package:flutter/material.dart';

class SaltAnimatedLoader extends StatefulWidget {
  final double size;

  const SaltAnimatedLoader({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  _SaltAnimatedLoaderState createState() => _SaltAnimatedLoaderState();
}

class _SaltAnimatedLoaderState extends State<SaltAnimatedLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.rotate(
          angle: _controller.value * math.pi,
          child: SizedBox(
            height: widget.size,
            width: widget.size,
            child: Image.asset('assets/icons/loader.png'),
          ),
        );
      },
    );
  }
}
