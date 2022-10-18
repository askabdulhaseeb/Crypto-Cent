import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/categories_provider.dart';
import '../../providers/product_provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import 'card_swiper.dart';
import 'categories/category.dart';
import 'latest_product/latest_product.dart';
import 'upload_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              // ignore: always_specify_types
              MaterialPageRoute(
                  builder: (BuildContext context) => UploadScreen()),
            );
          },
          child: const Icon(Icons.add)),
      body: Consumer2<ProductProvider, CategoriesProvider>(builder: (
        BuildContext context,
        ProductProvider productPro,
        CategoriesProvider catPro,
        _,
      ) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Headeriamge(),
                SizedBox(height: 20),
                ForText(
                  name: 'category',
                  bold: true,
                  size: 22,
                ),
                SizedBox(height: 20),
                CategoryScreen(),
                SizedBox(height: 20),
                ForText(
                  name: 'Latest Product',
                  bold: true,
                  size: 22,
                ),
                SizedBox(height: 20),
                LatestProduct(),
              ],
            ),
          ),
        );
      }),
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
        ),
        );
  }
}
