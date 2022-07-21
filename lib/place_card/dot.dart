import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final Color dotColor;
  final double dotSize;

  const Dot({
    required this.dotColor,
    required this.dotSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Center(
        child: Material(
          color: dotColor,
          type: MaterialType.circle,
          child: SizedBox(
            width: dotSize,
            height: dotSize,
          ),
        ),
      ),
    );
  }
}
