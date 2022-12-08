import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    int activeIndex = 0;
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 5,
      effect: SlideEffect(
        dotHeight: 8,
        dotWidth: 8,
        dotColor: Color(0xFFD9D9D9),
        activeDotColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
