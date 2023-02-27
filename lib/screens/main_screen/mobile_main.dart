import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/crypto_wallet/wallet_provider.dart';
import '../cart_screen/cart_screen.dart';
import '../chat_screen/chat_screen.dart';
import '../favorite_screen/favorite_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'main_navigationbar.dart';

class MobileMain extends StatefulWidget {
  const MobileMain({
    super.key,
    }) ;

  @override
  State<MobileMain> createState() => _MobileMainState();
}

class _MobileMainState extends State<MobileMain> {
   static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    if (AuthMethods.uid.isEmpty) return;
    load();
    //init();
   // listenNotification();
  }

  // listenNotification() {
  //   NotificationsServices.onNotification.stream.listen((String? event) {
  //     List<String> keys = event!.split('-');
  //     PushNotification().handleNotification(context: context, keys: keys);
  //   });
  // }

  // init() async {
  //   UserProvider userPro = Provider.of<UserProvider>(context, listen: false);
  //   if (userPro.users.isEmpty) return;
  //   AppUser me = userPro.user(AuthMethods.uid);
  //   PushNotification.instance
  //       .init(devicesToken: me.deviceToken ?? <MyDeviceToken>[]);
  //   Provider.of<PaymentProvider>(context, listen: false).load();
  // }

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
    return SafeArea(
      child: Scaffold(
        body: Consumer<AppProvider>(
          builder: (BuildContext context, AppProvider navBar, _) {
            return _pages[navBar.currentTap];
          },
        ),
        bottomNavigationBar: const MainBottomNavigationBar(),
      ),
    );
  }
}
