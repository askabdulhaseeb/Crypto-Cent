import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import 'custom_network_image.dart';

class CustomNetworkImageSlider extends StatelessWidget {
  const CustomNetworkImageSlider({Key? key}) : super(key: key);

  static List<String> imgList = <String>[
    AppImages.frame1,
    AppImages.frame2,
    AppImages.frame3,
    AppImages.frame4,
    AppImages.frame5,
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        //  height: width,
        aspectRatio: 1 / 1,

        // enlargeCenterPage: true,
      ),
      items: imgList
          .map((String item) => SizedBox(
                width: width,
                child: Image.asset(item),
              ))
          .toList(),
    );
  }
}
