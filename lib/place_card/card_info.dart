import 'package:flutter/material.dart';

import 'dot.dart';

class CardInfo extends StatelessWidget {
  final String budget;
  final String vibe;
  final String occasion;
  final TextStyle textStyle;
  final MainAxisAlignment align;

  const CardInfo({
    required this.budget,
    required this.vibe,
    required this.occasion,
    required this.textStyle,
    this.align = MainAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget dotSeparator = Container(
      width: 12,
      alignment: Alignment.center,
      child: Dot(
        dotColor: Colors.black.withOpacity(0.2),
        dotSize: 4,
      ),
    );

    return Row(
      mainAxisAlignment: align,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 135),
          child: Text(
            occasion,
            textAlign: TextAlign.center,
            style: textStyle,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
        dotSeparator,
        Container(
          constraints: const BoxConstraints(maxWidth: 135),
          child: Text(
            vibe,
            textAlign: TextAlign.center,
            style: textStyle,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
        dotSeparator,
        Container(
          constraints: const BoxConstraints(maxWidth: 50),
          child: Text(
            budget,
            textAlign: TextAlign.center,
            style: textStyle,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
