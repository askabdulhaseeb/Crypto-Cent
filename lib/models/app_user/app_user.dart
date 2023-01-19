// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../database/app_user/auth_method.dart';
import '../my_device_token.dart';
import '../reports/report_user.dart';
import 'numbers_detail.dart';

class AppUser {
  AppUser({
    required this.uid,
    required this.phoneNumber,
    this.name,
    this.imageURL,
    this.email,
    this.deviceToken,
    this.reports,
    this.blockTo,
    this.blockedBy,
  });
  final String uid;
  String? name;
  String? imageURL;
  final List<MyDeviceToken>? deviceToken;
  final NumberDetails phoneNumber;
  final String? email;
  final List<ReportUser>? reports;
  final List<String>? blockTo;
  final List<String>? blockedBy;
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
    List<ReportUser> reportInfo = <ReportUser>[];
    if (doc.data()!['devices_tokens'] != null) {
      doc.data()!['devices_tokens'].forEach((dynamic e) {
        dtData.add(MyDeviceToken.fromMap(e));
      });
    }
    if (doc.data()!['reports'] != null) {
      doc.data()!['reports'].forEach((dynamic e) {
        reportInfo.add(ReportUser.fromMap(e));
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
      reports: reportInfo,
      blockTo: List<String>.from(doc.data()?['block_to'] ?? <String>[]),
      blockedBy: List<String>.from(doc.data()?['blocked_by'] ?? <String>[]),
    );
  }

  blockToUpdate() {
    return <String, dynamic>{
      'block_to': FieldValue.arrayUnion(blockTo ?? <String>[]),
    };
  }

  blockByUpdate() {
    return <String, dynamic>{
      'blocked_by': FieldValue.arrayUnion(blockedBy ?? <String>[]),
    };
  }

  unblockTO() {
    return <String, dynamic>{
      'block_to': FieldValue.arrayRemove(blockTo ?? <String>[]),
    };
  }

  unblockBy() {
    return <String, dynamic>{
      'blocked_by': FieldValue.arrayRemove(blockedBy ?? <String>[]),
    };
  }

  Map<String, dynamic> report() {
    final String me = AuthMethods.uid;
    if (!(blockedBy?.contains(me) ?? false)) {
      blockedBy?.add(me);
    }
    return <String, dynamic>{
      'report': FieldValue.arrayUnion(
          reports!.map((ReportUser e) => e.toMap()).toList()),
      'blocked_by': FieldValue.arrayUnion(blockedBy!),
    };
  }
}
