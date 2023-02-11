import 'package:flutter/material.dart';

class SaltIconButton extends StatelessWidget {
  final String iconSrc;
  final VoidCallback callback;
  final double size;

  const SaltIconButton({
    Key? key,
    required this.iconSrc,
    required this.callback,
    this.size = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: GestureDetector(
        onTap: callback,
        child: Image.asset(iconSrc),
      ),
    );
  }
}
