import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utilities/app_images.dart';
import 'custom_network_image.dart';
import 'custom_page_indicator.dart';

class CustomNetworkImageSlider extends StatefulWidget {
  CustomNetworkImageSlider({Key? key}) : super(key: key);

  static List<String> imgList = <String>[
    AppImages.frame1,
    AppImages.frame2,
    AppImages.frame3,
    AppImages.frame4,
    AppImages.frame5,
  ];

  @override
  State<CustomNetworkImageSlider> createState() =>
      _CustomNetworkImageSliderState();
}

class _CustomNetworkImageSliderState extends State<CustomNetworkImageSlider> {
  CarouselController controller = CarouselController();

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // return CarouselSlider(
    //   options: CarouselOptions(
    //     autoPlay: true,
    //     viewportFraction: 1,
    //     //  height: width,
    //     aspectRatio: 1 / 1,

    //     // enlargeCenterPage: true,
    //   ),
    //   items: imgList
    //       .map((String item) => SizedBox(
    //             width: width,
    //             child: Image.asset(item),
    //           ))
    //       .toList(),
    // );
    return Stack(
      children: [
        CarouselSlider.builder(
            carouselController: controller,
            itemCount: CustomNetworkImageSlider.imgList.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return SizedBox(
                width: width,
                child: Image.asset(CustomNetworkImageSlider.imgList[index]),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              //  height: width,
              aspectRatio: 1 / 1,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            )),
        Positioned(
          left: 10,
          right: 10,
          bottom: 10,
          child: Center(child: buildIndicator(context)),
        ),
      ],
    );
  }

  Widget buildIndicator(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,

      count: CustomNetworkImageSlider.imgList.length,
      // ignore: prefer_const_constructors
      effect: WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        dotColor: Color(0xFFD9D9D9),
        activeDotColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
