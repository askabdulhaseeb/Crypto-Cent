import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../database/crypto_wallet/wallet_creation.dart';
import '../../../function/web_appbar.dart';
import '../../../providers/app_provider.dart';
import '../../../utilities/app_images.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/footer_widget.dart';
import '../../main_screen/main_screen.dart';
import '../phone_number_screen.dart';
import '../signin_screen/signin_screen.dart';
import '../signin_screen/signin_mobview.dart';

class WelcomeWebview extends StatelessWidget {
  const WelcomeWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebAppBar.webAppBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Utilities.tabMaxWidth),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Image.asset(AppImages.logo)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: SizedBox(
                                width: 180,
                                child: Image.asset(AppImages.logo),
                              ),
                            ),
                            const Text(
                              'Welcome Back!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Text(
                              'Choose the Signin method to enjoy all features',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 50),
                            CustomElevatedButton(
                              title: 'Login with email',
                              borderRadius: BorderRadius.circular(24),
                              onTap: () async {
                                Navigator.of(context)
                                    .pushNamed(SignInScreen.routeName);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(32),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                          height: 0.5, color: Colors.grey)),
                                  const Text('  OR  '),
                                  Expanded(
                                      child: Container(
                                          height: 0.5, color: Colors.grey)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    await HapticFeedback.heavyImpact();
                                    Navigator.of(context)
                                        .pushNamed(PhoneNumberScreen.routeName);
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    child: const Icon(Icons.mobile_friendly,
                                        color: Colors.blue),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    //await HapticFeedback.heavyImpact();
                                    int index =
                                        await AuthMethods().signinWithGoogle();
                                    if (index == -1) {
                                      return;
                                    } else if (index == 0) {
                                      // await NotificationsServices().onLogin(context);
                                      bool temp1 =
                                          await WalletCreation().addWallet();
                                      if (temp1) {
                                        Provider.of<AppProvider>(context,
                                                listen: false)
                                            .onTabTapped(0);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          MainScreen.routeName,
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    child: SizedBox(
                                      height: 20,
                                      child: Image.asset(AppImages.googleLogo),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await HapticFeedback.heavyImpact();
                                    // TODO: SIGN IN WITH APPLE
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    child: const Icon(Icons.apple,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
