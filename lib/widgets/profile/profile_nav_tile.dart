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
            ImageIcon(AssetImage(image), color: Colors.black),
            const SizedBox(width: 16),
            ForText(name: name, size: 18),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
