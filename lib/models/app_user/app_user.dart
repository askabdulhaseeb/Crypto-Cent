// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import '../my_device_token.dart';
import 'numbers_detail.dart';

class AppUser {
  final String uid;
  String? name;
  String? imageURL;
  final List<MyDeviceToken>? deviceToken;
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
      'devices_tokens':
          deviceToken?.map((MyDeviceToken e) => e.toMap()).toList() ?? [],
    };
  }

  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<MyDeviceToken> dtData = <MyDeviceToken>[];
    if (doc.data()!['devices_tokens'] != null) {
      doc.data()!['devices_tokens'].forEach((dynamic e) {
        dtData.add(MyDeviceToken.fromMap(e));
      });
    }
    return AppUser(
      uid: doc.data()?['uid'] ?? '',
      phoneNumber: NumberDetails.fromMap(
          doc.data()?['number_details'] ?? <String, dynamic>{}),
      name: doc.data()?['display_name'] ?? '',
      imageURL: doc.data()?['image_url'] ?? '',
      email: doc.data()?['email'] ?? '',
      deviceToken: dtData,
    );
  }
}
