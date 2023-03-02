import 'package:flutter/material.dart';

import '../cutom_text.dart';

class HeaderTextWidget extends StatelessWidget {
  const HeaderTextWidget({
    super.key,
    required this.name,
    required this.color,
    required this.image,
    required this.ontap,
  });

  final String name;
  final Color color;
  final String image;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: ontap,
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
      ),
    );
  }
}