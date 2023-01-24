import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../../custom_widgets/custom_widget.dart';

class ContactItem extends StatelessWidget {
  ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  static const double height = 72.0;

  final Contact contact;

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

  String text =
      'Download our app now for a convenient and seamless experience. Available on both iOS and Android. Download now!\n www.bloodo.com';
  String link = 'www.google.com';
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
                onTap: () {
                  onShare(context);
                },

                // textStyle: TextStyle(
                //     color: Theme.of(context).secondaryHeaderColor, fontSize: 18),
                border: Border.all(color: Theme.of(context).primaryColor),
                padding: const EdgeInsets.symmetric(horizontal: 6),
              ))),
    );
  }

  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(text,
        subject: link,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

}
