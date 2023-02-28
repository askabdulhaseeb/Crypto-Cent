import 'package:flutter/material.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});
  static const String routeName = '/disclaimer';

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [
      headingText('ADISCLAIMER\n\n'),
      headingText2('Last updated February 06, 2023\n\n'),
      headingText('\n\nWEBSITE DISCLAIMER\n\n'),
      regularText(
          '''The information provided by Boloodo ('we', 'us', or 'our') on'''),
      onTapText('''https://www.boloodo.com'''),
      regularText(
          '''(the 'Site') and our mobile application is for general informational purposes only. All information on the Site and our mobile application is provided in good faith, however we make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability, or completeness of any information on the Site or our mobile application. UNDER NO CIRCUMSTANCE SHALL WE HAVE ANY LIABILITY TO YOU FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF THE SITE OR OUR MOBILE APPLICATION OR RELIANCE ON ANY INFORMATION PROVIDED ON THE SITE AND OUR MOBILE APPLICATION. YOUR USE OF THE SITE AND OUR MOBILE APPLICATION AND YOUR RELIANCE ON ANY INFORMATION ON THE SITE AND OUR MOBILE APPLICATION IS SOLELY AT YOUR OWN RISK.'''),
      headingText('\n\nEXTERNAL LINKS DISCLAIMER\n\n'),
      regularText(
          '''The Site and our mobile application may contain (or you may be sent through the Site or our mobile application) links to other websites or content belonging to or originating from third parties or links to websites and features in banners or other advertising. Such external links are not investigated, monitored, or checked for accuracy, adequacy, validity, reliability, availability, or completeness by us. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR THE ACCURACY OR RELIABILITY OF ANY INFORMATION OFFERED BY THIRD-PARTY WEBSITES LINKED THROUGH THE SITE OR ANY WEBSITE OR FEATURE LINKED IN ANY BANNER OR OTHER ADVERTISING. WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES.'''),
      headingText('\n\nPROFESSIONAL DISCLAIMER\n\n'),
      regularText(
          '''The Site cannot and does not contain e commerce platform advice. The e commerce platform information is provided for general informational and educational purposes only and is not a substitute for professional advice. Accordingly, before taking any actions based upon such information, we encourage you to consult with the appropriate professionals. We do not provide any kind of e commerce platform advice. THE USE OR RELIANCE OF ANY INFORMATION CONTAINED ON THE SITE OR OUR MOBILE APPLICATION IS SOLELY AT YOUR OWN RISK.'''),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
          child: RichText(
            text: TextSpan(
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  TextSpan headingText(String Text) {
    return TextSpan(
        text: Text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
  }

  TextSpan headingText2(String Text) {
    return TextSpan(
        text: Text, style: const TextStyle(fontSize: 14, color: Colors.grey));
  }

  TextSpan regularText(String Text) {
    return TextSpan(text: Text, style: const TextStyle(fontSize: 16));
  }

  TextSpan onTapText(String Text) {
    return TextSpan(
        text: Text,
        style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontSize: 16));
  }

  TextSpan tableofContentText(String Text) {
    return TextSpan(
        text: '$Text\n\n',
        style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontSize: 16));
  }

  TextSpan regularTextBold(String Text) {
    return TextSpan(
        text: Text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }
}
