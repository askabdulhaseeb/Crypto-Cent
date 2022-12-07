import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _mobileContacts = [];
  List<Contact> get mobileContact => _mobileContacts;

  Future<bool> loadContacts(BuildContext context) async {
    bool temp = false;
    await Permission.contacts.request();
    final status = await Permission.contacts.status;
    print(status.name);
    if (await Permission.contacts.isGranted) {
      _mobileContacts = await FastContacts.allContacts;
      temp = true;
    } else {
      openAppSettings();

      Navigator.of(context).pop();
    }
    return temp;
  }
}
