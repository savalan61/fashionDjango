import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
      {super.key, required this.text, required this.style, this.maxLine = 1, this.overflow = TextOverflow.fade});

  final String text;
  final TextStyle style;
  final int maxLine;
  final TextOverflow overflow;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.left,
      overflow: overflow,
      style: style,
    );
  }
}
