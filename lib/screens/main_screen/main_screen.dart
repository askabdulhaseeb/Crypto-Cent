import '../../providers/auth_provider.dart';
import '../../providers/crypto_wallet/wallet_provider.dart';
import '../../utilities/app_images.dart';
import '../empty_screen/empty_screen.dart';
import '../screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    EmptyScreen(),
    ProfileScreen(),
  ];
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
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider navBar, _) {
          return _pages[navBar.currentTap];
        },
      ),
      bottomNavigationBar: const MainBottomNavigationBar(),
    );
  }
}
