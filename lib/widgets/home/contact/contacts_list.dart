import 'package:crypto_cent/widgets/home/contact/bloodo_contacts.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../providers/contact_provider.dart';
import 'all_contacts.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(builder:
        (BuildContext context, ContactProvider contactPro, Widget? snapshot) {
      List<Contact> mobileContacts = contactPro.mobileContact;
      int bloodoContactLength = contactPro.blodooUser.length;

      return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              const Text('Contacts'),
              Text(contactPro.mobileContact.length.toString()),
            ],
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                child: Icon(
                  CupertinoIcons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: ListView.builder(
          itemCount: mobileContacts.length,
          itemBuilder: (BuildContext context, int index) {
            if (index >= bloodoContactLength) {
              return ContactItem(
                contact: mobileContacts[index],
              );
            } else {
              return BloodoContacts(
                user: contactPro.blodooUser[index],
              );
            }
          },
        ),
      );
    });
  }
}
