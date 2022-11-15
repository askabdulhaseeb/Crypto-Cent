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
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider navBar, _) {
      final int currentTap = navBar.currentTap;
      return CurvedNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        animationCurve: Curves.ease,
        index: currentTap,
        // key: _bottomNavigationKey,
        onTap: (int index) => navBar.onTabTapped(index),
        items: <Widget>[
          ImageIcon(
            AssetImage(
              currentTap == 0
                  ? AppImages.homeUnselected
                  : AppImages.homeSelected,
            ),
            color: currentTap == 0 ? Theme.of(context).primaryColor : null,
          ),
          Icon(
            currentTap == 1 ? Icons.favorite : Icons.favorite_border,
            color: currentTap == 1 ? Theme.of(context).primaryColor : null,
          ),
          Icon(
            currentTap == 2
                ? Icons.shopping_cart
                : Icons.shopping_cart_outlined,
            color: currentTap == 2 ? Theme.of(context).primaryColor : null,
          ),
          Icon(
            currentTap == 3
                ? Icons.notifications_active
                : Icons.notifications_active_outlined,
            color: currentTap == 3 ? Theme.of(context).primaryColor : null,
          ),
          ImageIcon(
            AssetImage(
              currentTap == 4
                  ? AppImages.profileSelected
                  : AppImages.profileUnselected,
            ),
            color: currentTap == 4 ? Theme.of(context).primaryColor : null,
          )
        ],
      );
    });
  }
}
