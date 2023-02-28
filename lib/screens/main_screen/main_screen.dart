import 'package:flutter/material.dart';

import '../../utilities/responsive.dart';
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
    double width=MediaQuery.of(context).size.width;
    return ResponsiveApp(
      mobile: const MobileMain(),
    
      tablet:   WebMain(),
      desktop: WebMain(),
    );
  }
}
