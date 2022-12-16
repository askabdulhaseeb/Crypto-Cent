// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'numbers_detail.dart';

class AppUser {
  final String uid;
  String? name;
  String? imageURL;
  List<String>? deviceToken;
  final NumberDetails phoneNumber;
  final String? email;
  AppUser({
    required this.uid,
    required this.phoneNumber,
    this.name,
    this.imageURL,
    this.email,
    this.deviceToken,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'display_name': name ?? '',
      'number_details': phoneNumber.toMap(),
      'image_url': imageURL ?? '',
      'email': email ?? '',
      'devices_token': deviceToken ?? [],
    };
  }

  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUser(
      uid: doc.data()?['uid'] ?? '',
      phoneNumber: NumberDetails.fromMap(
          doc.data()?['number_details'] ?? <String, dynamic>{}),
      name: doc.data()?['display_name'] ?? '',
      imageURL: doc.data()?['image_url'] ?? '',
      email: doc.data()?['email'] ?? '',
      deviceToken: List<String>.from(doc.data()?['devices_token'] ?? []),
    );
  }
}
