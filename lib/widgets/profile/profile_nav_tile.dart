// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../custom_widgets/cutom_text.dart';

class ProfileNavTile extends StatelessWidget {
  const ProfileNavTile({
    required this.name,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String name;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xffF6F7F9),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 24),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image)),
              ),
            ),
            const SizedBox(width: 16),
            ForText(name: name, size: 18),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
