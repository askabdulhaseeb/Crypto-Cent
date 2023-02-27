import '../../database/app_user/auth_method.dart';
import '../../database/notification_services.dart';
import '../../function/push_notification.dart';
import '../../models/app_user/app_user.dart';
import '../../models/my_device_token.dart';
import '../../providers/auth_provider.dart';
import '../../providers/crypto_wallet/wallet_provider.dart';
import '../../providers/payment/payment_provider.dart';
import '../../providers/user_provider.dart';
import '../../utilities/responsive.dart';
import '../chat_screen/chat_screen.dart';
import '../screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import 'mobile_main.dart';
import 'web_main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 
  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      mobile: MobileMain(),
      tablet:  MobileMain(),
      desktop: WebMain(),
    );
  }
}

