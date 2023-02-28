import 'package:flutter/material.dart';

import '../../pages/support_page.dart';
import '../../policies_pages/privacy_policy.dart';
import '../../policies_pages/shipping_delivery.dart';
import '../../policies_pages/term_and_condition_page.dart';
import '../../utilities/app_images.dart';
import '../../utilities/utilities.dart';
import 'custom_widget.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Container(
        constraints: BoxConstraints(maxWidth: Utilities.tabMaxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: Image.asset(AppImages.logo),
                  ),
                  Row(
                    children: [
                      socialMedia(images: AppImages.facebook),
                      socialMedia(images: AppImages.instagram),
                      socialMedia(images: AppImages.twitter),
                      socialMedia(images: AppImages.linkedin),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  customText(text: 'About', onTap: () {}),
                  customText(text: 'Contact us', onTap: () {
                     Navigator.pushNamed(context, SupportPage.routePath);
                  }),
                  customText(
                      text: 'Support',
                      onTap: () {
                        Navigator.pushNamed(context, SupportPage.routePath);
                      }),
                  customText(text: 'Careers', onTap: () {}),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  customText(text: 'Share Location', onTap: () {}),
                  customText(
                      text: 'Orders Tracking',
                      onTap: () {
                        Navigator.pushNamed(
                            context, ShippingandDelivery.routeName);
                      }),
                  customText(text: 'Size Guide', onTap: () {}),
                  customText(
                      text: 'FAQs',
                      onTap: () {
                        //Navigator.pushNamed(context, SupportPage.routePath);
                      }),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  customText(
                      text: 'Terms & conditions',
                      onTap: () {
                        Navigator.pushNamed(
                            context, TermAndConditionPage.routeName);
                      }),
                  customText(
                      text: 'Privacy Policy',
                      onTap: () {
                        Navigator.pushNamed(context, PrivacyPolicy.routeName);
                      }),
                ],
              ),
              const SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget customText({required String text, required VoidCallback onTap}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextButton(
            onPressed: onTap,
            child: ForText(
              name: text,
              color: Colors.grey,
              size: 18,
            )),
      );

  Widget socialMedia({required String images}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        height: 30,
        width: 30,
        child: Image.asset(images),
      ),
    );
  }
}
