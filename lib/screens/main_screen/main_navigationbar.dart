import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../utilities/app_images.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    AppProvider navBar = Provider.of<AppProvider>(context);
    return CurvedNavigationBar(
      backgroundColor: Theme.of(context).backgroundColor,
      animationCurve: Curves.ease,
      index: navBar.currentTap,
      key: _bottomNavigationKey,
      onTap: (int index) => navBar.onTabTapped(index),
      items: <Widget>[
        ImageIcon(AssetImage(AppImages.homeUnselected)),
        const Icon(Icons.favorite_border),
        const Icon(Icons.shopping_cart_outlined),
        const Icon(Icons.notifications_active_outlined),
      ],
    );
  }
}
