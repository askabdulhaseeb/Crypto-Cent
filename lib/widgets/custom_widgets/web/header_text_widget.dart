import 'package:flutter/material.dart';

import '../cutom_text.dart';

class HeaderTextWidget extends StatelessWidget {
  const HeaderTextWidget({
    super.key,
    required this.name,
    required this.color,
    required this.image,
  });

  final String name;
  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          ForText(
            name: name,
            size: 15,
            color: color,
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 15,
            width: 15,
            child: Image.asset(image, color: color),
          )
        ],
      ),
    );
  }
}