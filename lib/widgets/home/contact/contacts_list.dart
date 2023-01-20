import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../providers/provider.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_toast.dart';
import 'bloodo_contacts.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/contact_provider.dart';
import 'all_contacts.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    final ContactProvider contactPro =
        Provider.of<ContactProvider>(context, listen: false);
    final UserProvider userPro =
        Provider.of<UserProvider>(context, listen: false);
    bool temp = await contactPro.contactsPermission(context);
    log('In _init: permisson: $temp');
    if (temp) {
      contactPro.loadContacts(userPro.users);
    }
  }

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
                      child: Text(
                        'Boloodo Contacts',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    BloodoContacts(
                      user: contactPro.blodooUser[0],
                    )
                  ],
                );
              }
              if (index == bloodoContactLength) {
                return bloodoContactLength > 1
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18),
                            child: Text(
                              'Invite to Boloodo',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          ContactItem(
                            contact: mobileContacts[index],
                          )
                        ],
                      )
                    : const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        child: Text(
                          'Invite to Boloodo',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
              return ContactItem(
                contact: mobileContacts[index],
              );
            }
          },
        ),
      );
    });
  }
}
