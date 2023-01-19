import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/app_user/app_user.dart';
import '../../models/my_device_token.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import 'auth_method.dart';

class UserApi {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  Future<AppUser?> user({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(uid).get();
    if (!doc.exists) return null;
    final AppUser appUser = AppUser.fromDoc(doc);
    return appUser;
  }

  Future<List<AppUser>> getAllUsers() async {
    final List<AppUser> appUser = <AppUser>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();

    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      appUser.add(AppUser.fromDoc(element));
    }
    return appUser;
  }

  Future<void> setDeviceToken(List<MyDeviceToken> deviceToken) async {
    try {
      final String me = AuthMethods.uid;
      await _instance.collection(_collection).doc(me).update(<String, dynamic>{
        'devices_tokens':
            deviceToken.map((MyDeviceToken e) => e.toMap()).toList()
      });
    } catch (e) {
      print(e.toString());
      CustomToast.errorToast(message: 'Something Went Wrong');
    }
  }

  Future<void> updateProfile({required AppUser user}) async {
    if (user.uid != AuthMethods.uid) return;
    try {
      await _instance
          .collection(_collection)
          .doc(user.uid)
          .update(user.toMap());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<bool> register({required AppUser user}) async {
    try {
      await _instance.collection(_collection).doc(user.uid).set(user.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<void> unblockTo({required AppUser user}) async {
    try {
      await _instance
          .collection(_collection)
          .doc(user.uid)
          .update(user.unblockTO());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<void> unblockBy({required AppUser user}) async {
    try {
      await _instance
          .collection(_collection)
          .doc(user.uid)
          .update(user.unblockBy());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<void> blockTo({required AppUser user}) async {
    try {
      await _instance
          .collection(_collection)
          .doc(user.uid)
          .update(user.blockToUpdate());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<void> blockBy({required AppUser user}) async {
    try {
      await _instance
          .collection(_collection)
          .doc(user.uid)
          .update(user.blockByUpdate());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<void> report({required AppUser user}) async {
    try {
      await _instance
          .collection(_collection)
          .doc(user.uid)
          .update(user.report());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<String?> uploadProfilePhoto({required File file}) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('profile_photos/${AuthMethods.uid}')
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
