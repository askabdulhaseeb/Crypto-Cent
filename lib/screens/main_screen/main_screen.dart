import 'package:firebase_messaging/firebase_messaging.dart';

import '../../database/notification_services.dart';
import '../../function/push_notification.dart';
import '../../providers/auth_provider.dart';
import '../../providers/crypto_wallet/wallet_provider.dart';
import '../chat_screen/chat_screen.dart';
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
  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() async{
    load();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print('main main enter hova ha');
    //   PushNotification.instance.handleNotification(context);
    // });
    super.initState();
    listenNotification();
   
  }
 listenNotification() {
    NotificationsServices.onNotification.stream.listen((event) {
      print('Evenet ' + event!);
      
    });
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
