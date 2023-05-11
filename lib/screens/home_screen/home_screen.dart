import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../../database/app_user/auth_method.dart';
import '../../database/crypto_wallet/wallet_create_api.dart';
import '../../database/notification_services.dart';
import '../../enum/notification_type.dart';
import '../../function/encryption_function.dart';
import '../../models/app_user/app_user.dart';
import '../../models/crypto_wallet/wallet.dart';
import '../../providers/provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_network_image_slider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/custom_widgets/policy_widget.dart';
import '../../widgets/home/home_categories_list.dart';
import '../../widgets/product/latest_product.dart';
import '../about/aboust_us.dart';
import '../about/contact_us.dart';
import '../category_screens/some_categories.dart';
import '../notification_screen/notification_screen.dart';
import '../search_screen/search_screen.dart';
import '../category_screens/categories_extend.dart';
import '../category_screens/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? controller;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller!.duration = const Duration(milliseconds: 400);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userPro = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      drawer: drawerScreen(context),
      
      body: SafeArea(
        child: Consumer2<ProductProvider, CategoriesProvider>(builder: (
          BuildContext context,
          ProductProvider productPro,
          CategoriesProvider catPro,
          _,
        ) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    const CustomNetworkImageSlider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              _key.currentState!.openDrawer();
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: Image.asset(
                                  AppImages.drawerIcon,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: Image.asset(AppImages.logo),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              bottomSheet(context);
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).secondaryHeaderColor,
                              child: const Icon(
                                CupertinoIcons.search,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const ForText(name: 'Category', size: 18, bold: true),
                      TextButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute<CategoryScreen>(
                                  builder: (BuildContext context) =>
                                      const CategoryScreen()));
                        }),
                        child: ForText(
                          name: 'View All',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const HomeCategoriesList(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      ForText(name: 'Quick Picks', size: 18, bold: true),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SomeCategories(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const ForText(
                        name: 'Popular Products',
                        bold: true,
                        size: 18,
                      ),
                      TextButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute<CategoriesExtend>(
                                  builder: (BuildContext context) =>
                                      CategoriesExtend(categoryName: 'All')));
                        }),
                        child: ForText(
                          name: 'View All',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const LatestProductsList(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    color: Theme.of(context).secondaryHeaderColor,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const ForText(
                        name: 'Latest Products',
                        bold: true,
                        size: 18,
                      ),
                      TextButton(
                        onPressed: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute<CategoriesExtend>(
                                builder: (BuildContext context) =>
                                    CategoriesExtend(categoryName: 'All')),
                          );
                        }),
                        child: ForText(
                          name: 'View All',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const LatestProductsList(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    color: Theme.of(context).secondaryHeaderColor,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const ForText(
                        name: 'Browes Products',
                        bold: true,
                        size: 18,
                      ),
                      TextButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute<CategoriesExtend>(
                                  builder: (BuildContext context) =>
                                      CategoriesExtend(
                                        categoryName: 'All',
                                      )));
                        }),
                        child: ForText(
                          name: 'View All',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const LatestProductsList(),
                const SizedBox(height: 50),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<dynamic> bottomSheet(
    BuildContext context,
  ) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        transitionAnimationController: controller,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return const SerachScreen();
        });
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
                const ForText(name: 'More', bold: true, size: 18),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Provider.of<AppProvider>(context, listen: false)
                        .onTabTapped(0);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            ),
            const SizedBox(height: 20),
            drawerContainer(
              context,
              'Search',
              Icons.search,
              (() {
                Navigator.push(
                  context,
                  MaterialPageRoute<SerachScreen>(
                    builder: (BuildContext context) => const SerachScreen(),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            drawerImageContainer(
              context,
              'Home',
              ImageIcon(AssetImage(AppImages.homeUnselected)),
              (() {
                Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
                Navigator.pop(context);
              }),
            ),
            drawerImageContainer(
              context,
              'Notification',
              ImageIcon(AssetImage(AppImages.notification)),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute<NotificationScreen>(
                    builder: (BuildContext context) =>
                        const NotificationScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            drawerContainer(
              context,
              'Contact Us',
              Icons.phone,
              (() {
                Navigator.push(
                  context,
                  MaterialPageRoute<ContactUsScreen>(
                    builder: (BuildContext context) => const ContactUsScreen(),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            drawerImageContainer(
              context,
              'About Us',
              ImageIcon(AssetImage(AppImages.profileUnselected)),
              (() {
                Navigator.push(
                  context,
                  MaterialPageRoute<AboutUsScreen>(
                    builder: (BuildContext context) => const AboutUsScreen(),
                  ),
                );
              }),
            ),
            const Spacer(),
            const Center(child: PoliciesWidget()),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget drawerContainer(
      BuildContext context, String name, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Icon(icon),
              const SizedBox(
                width: 20,
              ),
              ForText(name: name)
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerImageContainer(
      BuildContext context, String name, ImageIcon icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              icon,
              const SizedBox(
                width: 20,
              ),
              ForText(name: name)
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        GestureDetector(
          onTap: () async {
            await HapticFeedback.heavyImpact();
            Navigator.push(
              context,
              MaterialPageRoute<SerachScreen>(
                builder: (BuildContext context) => const SerachScreen(),
              ),
            );
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            child: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
      centerTitle: true,
      title: Container(
        height: 32,
        width: 58,
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
