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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Text('Contact on list'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: contactPro.mobileContact.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final String phones = snapshot.data![index].phones[0];
                    // //final emails = snapshot.data![index].emails.join(', ');
                    // final String name = snapshot.data![index].displayName;
                    return ContactItem(
                      contact: contactPro.mobileContact[index],
                    );
                  },
                ),
              ),
            ],
          ));
    });
  }
}
