import 'package:flutter/material.dart';

import '../../../utilities/responsive.dart';
import 'signup_mobview.dart';
import 'signup_webview.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return const ResponsiveApp(
      desktop: SignupWebview(),
      tablet: SignupWebview(),
      mobile: SignupMobview(),
    );
  }
}
