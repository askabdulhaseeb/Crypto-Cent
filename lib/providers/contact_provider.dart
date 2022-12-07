import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _mobileContacts = [];
  List<Contact> get mobileContact => _mobileContacts;
  
}
