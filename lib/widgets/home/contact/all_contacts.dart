import 'package:crypto_cent/widgets/home/contact/contact_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/custom_widget.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  static final height = 72.0;

  final Contact contact;

  String get _subtitle {
    final phones = contact.phones.join(', ');
    final emails = contact.emails.join(', ');
    final name = contact.structuredName;
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
        trailing: const ForText(
          name: 'invite',
          color: Colors.green,
        ),
      ),
    );
  }
}
