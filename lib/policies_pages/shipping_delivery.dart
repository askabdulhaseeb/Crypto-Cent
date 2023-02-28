import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShippingandDelivery extends StatelessWidget {
  const ShippingandDelivery({super.key});
  static const String routeName = '/shipping-delivery';

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [
      headingText('SHIPPING & DELIVERY POLICY\n\n'),
      headingText2('Last updated February 06, 2023\n\n'),
      regularText(
          'This Shipping & Delivery Policy is part of our Terms and Conditions ("Terms") and should be therefore read alongside our main Terms:'),
      onTapText('http://www.boloodo.com \n\n'),
      regularText(
          'Please carefully review our Shipping & Delivery Policy when purchasing our products. This policy will apply to any order you place with us.'),
      headingText('\n\nWHAT ARE MY SHIPPING & DELIVERY OPTIONS?\n\n'),
      regularText(
          '''We offer various shipping options. In some cases a third-party supplier may be managing our inventory and will be responsible for shipping your products.'''),
      headingText('\n\nShipping Fees\n\n'),
      regularText('''We offer shipping at the following rates:


Standard including tracking details
 __________	__________
 __________	__________

All times and dates given for delivery of the products are given in good faith but are estimates only.

For EU and UK consumers: This does not affect your statutory rights. Unless specifically noted, estimated delivery times reflect the earliest available delivery, and  deliveries will be made within 30 days after the day we accept your order. For more information please refer to our Terms.

Sellers must provide accurate shipping tracking details to the buyers of their products'''),
      headingText('\n\nDO YOU DELIVER INTERNATIONALLY?\n\n'),
      regularText(
          '''We offer worldwide shipping. Free shipping is not valid on international orders.

For information about customs process:
All buyers will be liable for the costs of customs and excise relating to their countries
Please note, we may be subject to various rules and restrictions in relation to some international deliveries and you may be subject to additional taxes and duties over which we have no control. If such cases apply, you are responsible for complying with the laws applicable to the country where you live and will be responsible for any such additional costs or taxes.'''),
      headingText('\n\nWHAT HAPPENS IF MY ORDER IS DELAYED?\n\n'),
      regularText(
          '''The seller will inform the buyer of the delays and provide evidence of new delivery date or update the tracking details

For EU and UK consumers: This does not affect your statutory rights. For more information please refer to our Terms.'''),
      headingText('\n\nQUESTIONS ABOUT RETURNS?\n\n'),
      regularText(
          'If you have questions about returns, please review our Return Policy:'),
      onTapText('http://www.boloodo.com.'),
      headingText('\n\nHOW CAN YOU CONTACT US ABOUT THIS POLICY?\n\n'),
      regularText(
          '''If you have any further questions or comments, you may contact us by:
Email: info@boloodo.com'''),
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
