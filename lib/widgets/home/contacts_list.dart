import 'package:fast_contacts/fast_contacts.dart';
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
    } else
      return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: getContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final String phones = snapshot.data![index].phones[0];
                    // //final emails = snapshot.data![index].emails.join(', ');
                    // final String name = snapshot.data![index].displayName;
                    return ContactItem(contact: snapshot.data![index],);
                  },
                )
              : snapshot.hasError
                  ? const Text(' -ERROR-')
                  : const Text(' Fetching...');
        },
      ),
    );
  }
}
