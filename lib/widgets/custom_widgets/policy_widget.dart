import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliciesWidget extends StatelessWidget {
  const PoliciesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const String privacyPolicy = 'https://bloodo-app.web.app/#/privacy-policy';
    const String termAndCondition =
        'https://bloodo-app.web.app/#/term-condition';
    Future<void> _launchUrl(String value) async {
      if (!await launchUrl(Uri.parse(value))) {
        throw Exception('Could not launch $value');
      }
    }

    return Wrap(
      children: <Widget>[
        TextButton(
          onPressed: () => _launchUrl(privacyPolicy),
          child: const Text('Privacy Policy'),
        ),
        TextButton(
          onPressed: () => _launchUrl(termAndCondition),
          child: const Text('Terms and Conditions'),
        ),
      ],
    );
  }
}
