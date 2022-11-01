import '../../database/app_user/auth_method.dart';
import '../../providers/auth_provider.dart';
import '../../providers/crypto_wallet/wallet_provider.dart';
import '../../utilities/app_images.dart';
import '../empty_screen/empty_screen.dart';
import '../payment.dart';
import '../screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainScreen';

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    PaymentScreen(),
    ProfileScreen(),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    load();
    super.initState();
  }

  bool loading = false;
  void load() {
    setState(() {
      loading = true;
    });
    Provider.of<AuthProvider>(context, listen: false).getUser();
    Provider.of<WalletProvider>(context, listen: false).load();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<AppProvider>(context).currentTap;
    AppProvider navBar = Provider.of<AppProvider>(context);

    return loading
        ? const CircularProgressIndicator()
        : Scaffold(
            body: MainScreen._pages[currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                navBar.onTabTapped(2);
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).secondaryHeaderColor,
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    //color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            navBar.onTabTapped(0);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              navBar.currentTap == 0
                                  ? ImageIcon(
                                      AssetImage(
                                        AppImages.homeSelected,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : ImageIcon(
                                      AssetImage(AppImages.homeUnselected)),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            navBar.onTabTapped(1);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              navBar.currentTap == 1
                                  ? ImageIcon(
                                      AssetImage(
                                        AppImages.fvrtSelected,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : const Icon(Icons.favorite_border),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            navBar.onTabTapped(3);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              navBar.currentTap == 3
                                  ? Icon(
                                      Icons.notifications_active_outlined,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : const Icon(
                                      Icons.notifications_active_outlined),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            navBar.onTabTapped(4);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              navBar.currentTap == 4
                                  ? ImageIcon(
                                      AssetImage(
                                        AppImages.profileSelected,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : ImageIcon(AssetImage(AppImages.profileUnselected)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
