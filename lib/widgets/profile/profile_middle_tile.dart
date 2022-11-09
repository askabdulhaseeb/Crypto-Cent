import 'package:flutter/material.dart';

import '../custom_widgets/cutom_text.dart';

class ProfileMiddleTile extends StatelessWidget {
  const ProfileMiddleTile({required this.image, required this.text, super.key});
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 16),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(image),
            )),
          ),
          const SizedBox(width: 16),
          ForText(
            name: text,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
