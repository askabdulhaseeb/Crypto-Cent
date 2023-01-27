import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/app_user/app_user.dart';

class ContactProvider with ChangeNotifier {
  Future<bool> contactsPermission(BuildContext context) async {
    bool temp = false;
    await Permission.contacts.request();
    final PermissionStatus status = await Permission.contacts.status;
    print(status.name);
    if (await Permission.contacts.isGranted) {
      _mobileContacts = await FastContacts.getAllContacts();
      temp = true;
    } else {
      await openAppSettings();
    }
    return temp;
  }

  bool loadContacts(List<AppUser> value) {
    bool change = false;
    String mobileNumber = '';
    bool isFind = false;
    _blodooUser.clear();
    _boloodoContacts.clear();
    _inviteContacts.clear();
    if (kDebugMode) {
      print('Length of Phone Number: ${_mobileContacts.length}');
    }
    for (int i = 0; i < _mobileContacts.length; i++) {
      isFind = false;
      if (_mobileContacts[i].phones[0].number.isEmpty) {
        continue;
      }
      String temp = _mobileContacts[i].phones[0].number;
      temp = temp.replaceAll(' ', '');
      if (temp.length >= 10) {
        mobileNumber = temp.substring(temp.length - 10, temp.length);
      }

      for (int j = 0; j < value.length; j++) {
        if (mobileNumber == value[j].phoneNumber.number) {
          _blodooUser.add(value[j]);
          _boloodoContacts.add(_mobileContacts[i]);
          isFind = true;
          break;
        }
      }
      if (!isFind) {
        _inviteContacts.add(_mobileContacts[i]);
      }
    }
    _mobileContacts.clear();
    for (int i = 0; i < _boloodoContacts.length; i++) {
      _mobileContacts.add(_boloodoContacts[i]);
    }
    for (int i = 0; i < _inviteContacts.length; i++) {
      _mobileContacts.add(_inviteContacts[i]);
    }
    change = true;
    notifyListeners();
    return change;
  }

  String? _search;
  onSearch(String? value) {
    _search = value;
    notifyListeners();
  }

  List<Contact> forSearch() {
    _boloodoContacts.clear();
    _allContacts.clear();
    //final List<Contact> temp = <Contact>[];
    if (_search == null || (_search?.isEmpty ?? true)) {
      return _mobileContacts;
      //temp.add(_null);
    }
    for (Contact element in _mobileContacts) {
      if (element.displayName
          .toLowerCase()
          .startsWith((_search?.toLowerCase() ?? ''))) {
        _allContacts.add(element);
      }
    }
    return _allContacts;
  }
 List<AppUser> forUserSearch() {

    final List<AppUser> temp = <AppUser>[];
    if (_search == null || (_search?.isEmpty ?? true)) {
      return _blodooUser;
      //temp.add(_null);
    }
    for (AppUser element in _blodooUser) {
      if (element.name!
          .toLowerCase()
          .startsWith((_search?.toLowerCase() ?? ''))) {
        temp.add(element);
      }
    }
    return temp;
  }
  List<Contact> _mobileContacts = [];
  List<Contact> get mobileContact => _mobileContacts;
  List<Contact> _allContacts = [];
  List<Contact> get allContact => _allContacts;
  final List<Contact> _boloodoContacts = [];
  List<Contact> get boloodoContact => _boloodoContacts;
  final List<Contact> _inviteContacts = [];
  List<Contact> get inviteContact => _inviteContacts;
  final List<AppUser> _blodooUser = [];
  List<AppUser> get blodooUser => _blodooUser;
}
