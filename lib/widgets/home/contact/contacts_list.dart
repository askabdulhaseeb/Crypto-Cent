import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'all_contacts.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Future<List<Contact>> getContact() async {
    bool temp = await Permission.contacts.status.isGranted;

    if (!temp) {
      temp = await Permission.contacts.request().isGranted;
    }
    if (temp) {
      return FastContacts.allContacts;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Contacts'),
            FutureBuilder<List<Contact>>(
              future: getContact(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Contact>> snapshot) {
                return snapshot.hasData
                    ? Text(
                        snapshot.data!.length.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )
                    : snapshot.hasError
                        ? const Text(' -ERROR-')
                        : const Text(' Fetching...');
              },
            ),
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
      body: FutureBuilder<List<Contact>>(
        future: getContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          return snapshot.hasData
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: Text('Contact on list'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final String phones = snapshot.data![index].phones[0];
                          // //final emails = snapshot.data![index].emails.join(', ');
                          // final String name = snapshot.data![index].displayName;
                          return ContactItem(
                            contact: snapshot.data![index],
                          );
                        },
                      ),
                    ),
                  ],
                )
              : snapshot.hasError
                  ? const Text(' -ERROR-')
                  : const Text(' Fetching...');
        },
      ),
    );
  }
}
