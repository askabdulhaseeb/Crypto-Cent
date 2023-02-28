import 'package:flutter/material.dart';

import '../../utilities/responsive.dart';
import 'mobile_home_screen.dart';
import 'web_home_screen.dart';
class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});
@override
 Widget build(BuildContext context) {
return const ResponsiveApp(
desktop: WebHomeScreen(),
mobile: MobileHomeScreen(),
tablet: WebHomeScreen(),
);
}
}