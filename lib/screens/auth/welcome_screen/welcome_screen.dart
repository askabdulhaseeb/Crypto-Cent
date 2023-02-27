import 'package:flutter/material.dart';

import '../../../utilities/responsive.dart';
import 'welcome_mobview.dart';
import 'welcome_webview.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context) {
    return const ResponsiveApp(
      mobile: WelcomeMobview(),
      tablet: WelcomeMobview(),
      desktop: WelcomeWebview(),
    );
  }
}
