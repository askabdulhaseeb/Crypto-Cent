

import 'package:flutter/material.dart';

import 'show_loading.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    required this.imageURL,
    this.radius = 24,
    Key? key,
  }) : super(key: key);
  final String? imageURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return imageURL == null || (imageURL?.isEmpty ?? false)
        ? CircleAvatar(
            radius: radius - 2,
            child: CircleAvatar(
              radius: radius - 4,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Icon(Icons.person, size: radius),
            ),
          )
        : CircleAvatar(
            radius: radius - 2,
            backgroundImage:NetworkImage(imageURL!),
          );
  }
}
