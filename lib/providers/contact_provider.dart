import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactProvider with ChangeNotifier {
  

  Future<bool> contactsPermission(BuildContext context) async {
    bool temp = false;
    await Permission.contacts.request();
    final status = await Permission.contacts.status;
    print(status.name);
    if (await Permission.contacts.isGranted) {
      _mobileContacts = await FastContacts.allContacts;
      temp = true;
    } else {
      await openAppSettings();
    }
    return temp;
  }

  loadContacts(List<String> value) {
    String mobileNumber = '';
    bool isFind = false;
    for (int i = 0; i < _mobileContacts.length; i++) {
      String temp = _mobileContacts[i].phones[0];
      temp = temp.replaceAll(' ', '');
      if (temp.length >= 10) {
        mobileNumber = temp.substring(temp.length - 10, temp.length);
      }

      for (int j = 0; j < value.length; j++) {
        if (mobileNumber == value[j]) {
          print(_mobileContacts[i].displayName);
          _boloodoContacts.add(_mobileContacts[i]);
          isFind = true;
          break;
        }
      }
      if (!isFind) {
        _inviteContacts.add(_mobileContacts[i]);
      }
    }
  }
  List<Contact> _mobileContacts = [];
  List<Contact> get mobileContact => _mobileContacts;
  List<Contact> _boloodoContacts = [];
  List<Contact> get boloodoContact => _boloodoContacts;
  List<Contact> _inviteContacts = [];
  List<Contact> get inviteContact => _inviteContacts;

}
