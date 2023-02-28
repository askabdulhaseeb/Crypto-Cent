
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

class ShippingAndDeliveryPolicyPage extends StatelessWidget {
  const ShippingAndDeliveryPolicyPage({super.key});
  static const String routeName = '/shipping-delivery-policy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            Text(
              'SHIPPING & DELIVERY POLICY',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Last updated February 06, 2023',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text:
                        'This Shipping & Delivery Policy is part of our Terms and Conditions ("Terms") and should be therefore read alongside our main Terms: ',
                  ),
                  TextSpan(
                    text: 'http://www.boloodo.com',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Utilities().launchURL('http://www.boloodo.com');
                      },
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Please carefully review our Shipping & Delivery Policy when purchasing our products. This policy will apply to any order you place with us.',
            ),
            const SizedBox(height: 24),
            Text(
              'WHAT ARE MY SHIPPING & DELIVERY OPTIONS?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'We offer various shipping options. In some cases a third-party supplier may be managing our inventory and will be responsible for shipping your products.',
            ),
            const SizedBox(height: 16),
            Text(
              'Shipping Fees',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text('We offer shipping at the following rates:'),
          ],
        ),
      ),
    );
  }
}
