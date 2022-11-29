import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import 'phone_number_screen.dart';
import 'signin_with_email_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/welcome-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              'Choose the Signin method to enjoy all fetchers',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            CustomElevatedButton(
              title: 'Login with email',
              borderRadius: BorderRadius.circular(24),
              onTap: () => Navigator.of(context)
                  .pushNamed(SigninWithEmailScreen.routeName),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(height: 0.5, color: Colors.grey)),
                  const Text('  OR  '),
                  Expanded(child: Container(height: 0.5, color: Colors.grey)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async => Navigator.of(context)
                      .pushNamed(PhoneNumberScreen.routeName),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    child:
                        const Icon(Icons.mobile_friendly, color: Colors.blue),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: SIGN IN WITH GOOGLE
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    child: SizedBox(
                      height: 20,
                      child: Image.asset(AppImages.googleLogo),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // TODO: SIGN IN WITH APPLE
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    child: const Icon(Icons.apple, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
