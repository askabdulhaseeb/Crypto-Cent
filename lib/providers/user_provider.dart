import 'dart:developer';

import 'package:flutter/material.dart';

import '../database/app_user/auth_method.dart';
import '../database/app_user/user_api.dart';
import '../database/notification_services.dart';
import '../function/push_notification.dart';
import '../models/app_user/app_user.dart';
import '../models/app_user/numbers_detail.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    init();
  }
  List<AppUser> _user = <AppUser>[];
  List<String> _deviceToken = <String>[];
  List<String> get deviceToken => _deviceToken;
  AppUser? _currentUser;

  AppUser get currentUser => _currentUser ?? _null;
  Future<void> init() async {
    if (_user.isNotEmpty) return;
    final List<AppUser> temp = await UserApi().getAllUsers();
    _user = temp;
<<<<<<< HEAD
    for (int i = 0; i < _user.length; i++) {
      for (int j = 0; j < _user[i].deviceToken!.length; j++) {
        _deviceToken.add(_user[i].deviceToken![j]);
      }
    }

    List<String> getToken =
        await PushNotification().init(devicesToken: deviceToken) ?? [];
    // bool notificationSend = await PushNotification().sendNotification(
    //     data: ['f', 'usman'],
    //     deviceToken: _deviceToken,
    //     messageBody: 'MALIK DON',
    //     messageTitle: 'MALIK');

    // if (notificationSend) {
    //await NotificationsServices.init();
    // }
    print(_deviceToken[0]);
=======
   _currentUser= user(AuthMethods.uid);
>>>>>>> fc69de18b8d55a7269b8c097e257741938683c93
    notifyListeners();
  }

  Future<void> refresh() async {
    _user = await UserApi().getAllUsers();
    notifyListeners();
  }

  List<String> number() {
    List<String> temp = [];
    for (int i = 0; i < _user.length; i++) {
      temp.add(_user[i].phoneNumber.number);
    }
    return temp;
  }
  // block(AppUser user) async {
  //   int index = _indexOf(user.uid);
  //   int myIndex = _indexOf(AuthMethods.uid);
  //   if (index < 0 || myIndex < 0) return;
  //   if (_user[index].blockedBy != null ||
  //       (_user[index].blockedBy?.contains(AuthMethods.uid) ?? false)) {
  //     _user[index].blockedBy?.remove(AuthMethods.uid);
  //     _user[myIndex].blockTo?.remove(_user[index].uid);
  //     CustomToast.successToast(message: 'Unblocked');
  //     final AppUser by = _user[index];
  //     final AppUser to = _user[myIndex];
  //     by.blockedBy?.clear();
  //     to.blockTo?.clear();
  //     by.blockedBy?.add(AuthMethods.uid);
  //     to.blockTo?.add(by.uid);
  //     await UserApi().unblockBy(user: by);
  //     await UserApi().unblockTo(user: to);
  //   } else {
  //     log('blocking');
  //     _user[index].blockedBy?.add(AuthMethods.uid);
  //     _user[myIndex].blockTo?.add(_user[index].uid);
  //     CustomToast.successToast(message: 'Blocked');
  //     await UserApi().blockBy(user: _user[index]);
  //     await UserApi().blockTo(user: _user[myIndex]);
  //   }
  //   await refresh();
  // }

  // report(AppUser user, ReportUser repo) async {
  //   int index = _indexOf(user.uid);
  //   if (index < 0) return;
  //   _user[index].reports?.add(repo);
  //   notifyListeners();
  //   await UserApi().report(user: _user[index]);
  // }

  updateProfile(AppUser value) async {
    if (value.uid != AuthMethods.uid) return;
    int index = _indexOf(value.uid);
    if (index < 0) return;
    _user[index] = value;
    notifyListeners();
    await UserApi().updateProfile(user: _user[index]);
  }

  List<AppUser> usersFromListOfString({required List<String> uidsList}) {
    List<AppUser> tempList = <AppUser>[];
    for (String element in uidsList) {
      tempList.add(_user[_indexOf(element)]);
    }
    return tempList;
  }

  List<AppUser> get users => <AppUser>[..._user];

  AppUser user(String uid) {
    int index = _indexOf(uid);
    return index < 0 ? _null : _user[index];
  }

  int _indexOf(String uid) {
    int index = _user.indexWhere((AppUser element) => element.uid == uid);
    return index;
  }

  static AppUser get _null => AppUser(
        uid: 'null',
        name: 'null',
        phoneNumber: NumberDetails(
          countryCode: 'null',
          number: 'null',
          completeNumber: 'null',
          isoCode: 'null',
          timestamp: 0,
        ),
      );
}
