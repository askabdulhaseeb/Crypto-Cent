// ignore_for_file: library_private_types_in_public_api


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class Headeriamge extends StatefulWidget {
  const Headeriamge({Key? key}) : super(key: key);

  @override
  _HeaderiamgeState createState() => _HeaderiamgeState();
}

class _HeaderiamgeState extends State<Headeriamge> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height:  150.0,
        
      ),
      items: [1,2,3,4,5].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          // height: 170,
          // width: width * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xffcfcbc8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //const SizedBox(height: 20),
                    const ForText(
                      name: '30% Off',
                      bold: true,
                    ),
                    //const SizedBox(height: 20),
                    const ForText(
                      name: 'Gaming Controller',
                      bold: true,
                    ),
                    // const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16)),
                      child: const ForText(
                        name: 'free Delievery',
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.controller),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }).toList(),
    
     
    );
  }
}
