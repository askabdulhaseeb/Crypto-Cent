import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class EmptyAuthScreen extends StatelessWidget {
  const EmptyAuthScreen({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          // ignore: always_specify_types
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                SizedBox(
                  height: height * 0.77,
                  width: width,
                  //color: Colors.amber,
                  child: Image.asset(
                    AppImages.emptyProfile,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22)),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22)),
                          ),
                          child: Column(
                            children: <Widget>[
                              ForText(
                                name: text,
                                bold: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const ForText(
                                name:
                                    'You must be 18 or above to place an order,For customer in age 13-17 please ask a parent or guardian for conset. ',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomElevatedButton(
                                  title: 'Login',
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  onTap: () {},
                                  bgColor:
                                      const Color.fromARGB(255, 215, 236, 254)),
                              CustomElevatedButton(
                                  title: 'Create a account', onTap: () {}),
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.black54,
              thickness: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: always_specify_types
                  children: const [
                    Text(
                      'Help & Support',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}