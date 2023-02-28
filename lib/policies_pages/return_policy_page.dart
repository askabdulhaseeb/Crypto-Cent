import 'package:flutter/material.dart';

class ReturnPolicyPage extends StatelessWidget {
  const ReturnPolicyPage({super.key});
  static const String routeName = '/return-policy';

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [
      headingText('RETURN POLICY\n\n'),
      headingText2('Last updated February 06, 2023\n\n'),
      regularText(
          '''Thank you for your purchase. We hope you are happy with your purchase. However, if you are not completely satisfied with your purchase for any reason, you may return it to us for a full refund only. Please see below for more information on our return policy.'''),
      headingText('\n\n RETURNS\n\n'),
      regularText(
          '''All returns must be postmarked within seven (7) days of the purchase date. All returned items must be in new and unused condition, with all original tags and labels attached. '''),
      headingText('\n\n RETURN PROCESS\n\n'),
      regularText(
          ''' To return an item, please email customer service at info@boloodo.com to obtain a Return Merchandise Authorisation (RMA) number. After receiving a RMA number, place the item securely in its original packaging, and mail your return to the following address:

To the seller
Attn: Returns
RMA #
__________
__________, __________

Please note, you will be responsible for all return shipping charges. We strongly recommend that you use a trackable method to mail your return. '''),
      headingText('\n\n REFUNDS\n\n'),
      regularText(
          '''After receiving your return and inspecting the condition of your item, we will process your return. Please allow at least thirty (30) days from the receipt of your item to process your return. Refunds may take 1-2 billing cycles to appear on your credit card statement, depending on your credit card company. We will notify you by email when your return has been processed.'''),
      headingText('\n\n EXCEPTIONS\n\n'),
      regularText(
          ''' For defective or damaged products, please contact us at the contact details below to arrange a refund or exchange.

Please Note
     ●     Sale items are FINAL SALE and cannot be returned.
     ●     If an item or service is not to the expectation of the buyer, then the buyer has the right to obtain a refund from the seller.
     ●     Once the seller receives the item and is satisfied with the contents, the seller will initiate the refund
     ●     All refunds will be subject to network fees
     ●     __________'''),
      headingText('\n\n QUESTIONS\n\n'),
      regularText(''' 
If you have any questions concerning our return policy, please contact us at:

info@boloodo.com'''),
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
