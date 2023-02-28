
import 'package:flutter/material.dart';

import 'accebtable_use_policy_page.dart';
import 'cookie_policy.dart';
import 'disclaimer_page.dart';
import 'privacy_policy.dart';
import 'return_policy_page.dart';
import 'shipping_delivery.dart';
import 'term_and_condition_page.dart';
import 'user_license_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(PrivacyPolicy.routeName);
                      },
                      child: const Text('PRIVACY NOTICE')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(CookiesPolices.routeName);
                      },
                      child: const Text('COOKIE POLICY')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(TermAndConditionPage.routeName);
                      },
                      child: const Text('TERMS AND CONDITIONS')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(UserLicensePage.routeName);
                      },
                      child: const Text('EULA')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ReturnPolicyPage.routeName);
                      },
                      child: const Text('Return Policy')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(DisclaimerPage.routeName);
                      },
                      child: const Text('Disclaimer')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ShippingandDelivery.routeName);
                      },
                      child: const Text('Shipping Policy')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AcceptableUserPolicy.routeName);
                      },
                      child: const Text('ACCEPTABLE ')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
