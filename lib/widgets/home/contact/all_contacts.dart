import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../../custom_widgets/custom_widget.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({required this.contact, Key? key}) : super(key: key);

  final double height = 72.0;
  final Contact contact;
  final String text =
      'Download our app now for a convenient and seamless experience. Available on both iOS and Android. Download now!\n www.bloodo.com';
  final String link = 'www.google.com';

  String get _subtitle {
    final String phones = contact.phones.join(', ');
    final String emails = contact.emails.join(', ');
    final StructuredName? name = contact.structuredName;
    return [
      if (phones.isNotEmpty) phones,
      if (emails.isNotEmpty) emails,
      if (name != null)
        [
          if (name.namePrefix.isNotEmpty) name.namePrefix,
          if (name.givenName.isNotEmpty) name.givenName,
          if (name.middleName.isNotEmpty) name.middleName,
          if (name.familyName.isNotEmpty) name.familyName,
          if (name.nameSuffix.isNotEmpty) name.nameSuffix,
        ].join(', '),
    ].join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListTile(
          leading: ContactImage(contact: contact),
          title: Text(contact.displayName),
          // subtitle: Text(_subtitle),
          trailing: SizedBox(
              height: 60,
              width: 80,
              child: CustomElevatedButton(
                title: 'Invite',
                onTap: () async {
                  await HapticFeedback.heavyImpact();

                  _launchSMS(contact.phones[0].number, 'Download the bloodo app',context);

                },

                // textStyle: TextStyle(
                //     color: Theme.of(context).secondaryHeaderColor, fontSize: 18),
                border: Border.all(color: Theme.of(context).primaryColor),
                padding: const EdgeInsets.symmetric(horizontal: 6),
              ))),
    );
  }

  // Future<void> _launchUrl(String phoneNumber) async {
  //   if (!await launchUrl(Uri.parse('sms:$phoneNumber'))) {
  //     throw Exception('Could not launch $phoneNumber');
  //   }
  // }

  void _launchSMS(String phone, String message,BuildContext context) async {
     try {
      if (Platform.isAndroid) {
        String uri = 'sms:$phone?body=$message';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri = 'sms:$phone&body=$message';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occurred. Please try again!'),
        ),
      );
    }
    // var url = 'sms:$phone?body=$message';
    // if (!await launchUrl(Uri.parse(url))) {
    //   throw 'Could not launch $url';
    // }
  }

  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(text,
        subject: link,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
