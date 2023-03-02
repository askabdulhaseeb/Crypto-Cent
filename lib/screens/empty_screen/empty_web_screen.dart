import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../function/web_appbar.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../auth/welcome_screen/welcome_screen.dart';

class EmptyWebAuthScreen extends StatelessWidget {
  const EmptyWebAuthScreen({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WebAppBar().webAppBar(context),
      body: SafeArea(
        child: Column(
          // ignore: always_specify_types
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                SizedBox(
                  height: height*0.9 ,
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
                                    'You must be 18 or over to place an order or have the permission of a parent or guardian ',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomElevatedButton(
                                  title: 'Login',
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  onTap: () async {
                                    await HapticFeedback.heavyImpact();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            WelcomeScreen.routeName,
                                            (Route<dynamic> route) => false);
                                  },
                                  bgColor:
                                      const Color.fromARGB(255, 215, 236, 254)),
                              CustomElevatedButton(
                                title: 'Create a account',
                                onTap: () async {
                                  await HapticFeedback.heavyImpact();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      WelcomeScreen.routeName,
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ],
                          ),
                        )),
                  ),
                )
               
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
