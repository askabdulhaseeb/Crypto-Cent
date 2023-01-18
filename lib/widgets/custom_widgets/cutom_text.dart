import 'package:flutter/material.dart';

class ForText extends StatelessWidget {
  const ForText({
    required this.name,
    this.size,
    this.bold,
    this.color,
    this.textStyle,
    Key? key,
  }) : super(key: key);
  final String name;
  final double? size;
  final bool? bold;
  final Color? color;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      name,
      
      style: textStyle ??
          TextStyle(
            color: color ?? Colors.black,
            fontSize: size,
            fontWeight: bold == true ? FontWeight.w800 : FontWeight.w400,
          ),
    );
  }
}
