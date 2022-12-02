import 'package:flutter/material.dart';
import '../../utilities/app_images.dart';

class ProductChatPhoto extends StatelessWidget {
  const ProductChatPhoto({
    required this.userImage,
    required this.productImage,
    required this.radius,
    Key? key,
  }) : super(key: key);
  final String userImage;
  final String productImage;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + 2,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 2,
            left: 6,
            child: userImage.isEmpty
                ? CircleAvatar(
                    radius: radius / 2,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: radius / 2 - 2,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage(AppImages.profileSelected),
                    ),
                  )
                : CircleAvatar(
                    radius: radius / 2,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(userImage),
                  ),
          ),
          Positioned(
            bottom: 2,
            right: 6,
            child: CircleAvatar(
              radius: radius / 2 + 4,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(productImage),
            ),
          ),
        ],
      ),
    );
  }
}
