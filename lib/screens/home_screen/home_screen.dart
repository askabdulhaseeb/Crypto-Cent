import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../providers/categories_provider.dart';
import '../../providers/product_provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../search_screen/search_screen.dart';
import 'all_contacts_catrgories/all_screen.dart';
import 'card_swiper.dart';
import 'categories/category.dart';
import 'latest_product/latest_product.dart';
import 'upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/HomeScreen';
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context),
      drawer: drawerScreen(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              // ignore: always_specify_types
              MaterialPageRoute(
                  builder: (BuildContext context) => const UploadScreen()),
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
                //CategoryScreen(),
                AllScreen(),
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

  Widget drawerScreen(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .onTabTapped(0);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Spacer(),
                const ForText(name: 'More', bold: true),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .onTabTapped(0);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel_outlined)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              color: Theme.of(context).secondaryHeaderColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.search),
                    SizedBox(
                      width: 20,
                    ),
                    ForText(name: 'Search')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              // ignore: always_specify_types
              MaterialPageRoute(
                builder: (BuildContext context) => const SerachScreen(),
              ),
            );
          },
          splashRadius: 20,
          icon: Icon(
            CupertinoIcons.search,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
      centerTitle: false,
      title: Container(
        height: 40,
        width: 80,
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
