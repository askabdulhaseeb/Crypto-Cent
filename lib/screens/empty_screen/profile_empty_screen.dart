import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';

class EmptyProfileScreen extends StatelessWidget {
  const EmptyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.7,
              width: width,
              //color: Colors.amber,
              child: Image.asset(
                AppImages.emptyProfile,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.black,
            ))
          ],
        ),
      ),
    );
  }
}
