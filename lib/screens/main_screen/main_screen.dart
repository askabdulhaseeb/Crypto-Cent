import '../../database/app_user/auth_method.dart';
import '../../database/notification_services.dart';
import '../../function/push_notification.dart';
import '../../models/app_user/app_user.dart';
import '../../models/my_device_token.dart';
import '../../providers/auth_provider.dart';
import '../../providers/crypto_wallet/wallet_provider.dart';
import '../../providers/payment/payment_provider.dart';
import '../../providers/user_provider.dart';
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
    init();
    listenNotification();
  }

  listenNotification() {
    NotificationsServices.onNotification.stream.listen((String? event) {
      List<String> keys = event!.split('-');
      PushNotification().handleNotification(context: context, keys: keys);
    });
  }

  init() async {
    UserProvider userPro = Provider.of<UserProvider>(context, listen: false);
    if (userPro.users.isEmpty) return;
    AppUser me = userPro.user(AuthMethods.uid);
    PushNotification.instance
        .init(devicesToken: me.deviceToken ?? <MyDeviceToken>[]);
    Provider.of<PaymentProvider>(context, listen: false).load();
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
