import 'package:flutter/material.dart';

import '../../../utilities/responsive.dart';
import 'signin_mobview.dart';
import 'signin_webview.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return const ResponsiveApp(
      desktop: SignInWebview(),
      mobile: SigninMobview(),
      tablet: SignInWebview(),
    );
  }
}
