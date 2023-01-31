import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_network_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.url, super.key});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CustomNetworkImage(imageURL: url, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
