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
            if (bloodoContactLength > 0) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('contacts on Boloodo'),
                    ),
                    BloodoContacts(
                      user: contactPro.blodooUser[0],
                    )
                  ],
                );
              }
              if (index == bloodoContactLength) {
                return bloodoContactLength>1? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: Text(
                        'Invite on Boloodo',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ContactItem(
                      contact: mobileContacts[index],
                    )
                  ],
                ):const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: Text(
                        'Invite on Boloodo',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    );
              }
              if (index > bloodoContactLength) {
                return ContactItem(
                  contact: mobileContacts[index],
                );
              } else {
                return BloodoContacts(
                  user: contactPro.blodooUser[index],
                );
              }
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
