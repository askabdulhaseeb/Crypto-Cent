import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _mobileContacts = [];
  List<Contact> get mobileContact => _mobileContacts;
  Future<bool> loadContact() async {
    bool temp = await Permission.contacts.status.isGranted;

    if (!temp) {
      temp = await Permission.contacts.request().isGranted;
      if (await Permission.contacts.request().isDenied) {
        return false;
      }
    }
    if (temp) {
      _mobileContacts = await FastContacts.allContacts;
    } else {
      _mobileContacts = [];
    }
    return temp;
  }
}
