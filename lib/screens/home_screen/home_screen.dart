import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import 'card_swiper.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      body: Column(
        children: const <Widget>[
          Headeriamge(),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 30,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.drawer),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        title: Container(
          height: 60,
          width: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.logo),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
