import 'dart:core';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/app_user/auth_method.dart';
import '../database/app_user/user_api.dart';
import '../database/notification_services.dart';
import '../models/my_device_token.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class PushNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final PushNotification instance = PushNotification();

  String? _token;
  String? get token => _token;

  Future<List<MyDeviceToken>?>? init(
      {required List<MyDeviceToken> devicesToken}) async {
    final NotificationSettings? settings = await _requestPermission();
    if (settings!.authorizationStatus == AuthorizationStatus.authorized) {}
    if ((settings.authorizationStatus == AuthorizationStatus.provisional ||
        settings.authorizationStatus == AuthorizationStatus.authorized)) {
      List<MyDeviceToken>? updatedDevicesToken = await getToken(devicesToken);
      if (updatedDevicesToken != null && updatedDevicesToken.isNotEmpty) {
        return updatedDevicesToken;
      }
    } else {
      CustomToast.errorToast(
          message: 'Permissions are neccessary for notifications');
    }
    return null;
  }

  Future<List<MyDeviceToken>?>? getToken(
      List<MyDeviceToken> devicesToken) async {
    if (AuthMethods.uid.isEmpty) return null;
    _token = await _firebaseMessaging.getToken();
    log('CURRENT DEVICE TOKEN');
    if (_token == null) {
      CustomToast.errorToast(
          message: 'Unable to fetch Device token, Try again later');
      return null;
    }
    final bool exist = NotificationsServices().tokenAlreadyExist(
        devicesValue: devicesToken, tokenValue: _token ?? '');
    if (kDebugMode) {
      print('Deiver Token already exist: $exist');
    }
    if (exist) return devicesToken;
    devicesToken.add(MyDeviceToken(token: _token ?? ''));
    UserApi().setDeviceToken(devicesToken);
    return devicesToken;
  }

  Future<bool> sendNotification({
    required List<String> deviceToken,
    required String messageTitle,
    required String messageBody,
    required List<String> dataa,
  }) async {
    String value3 = dataa.length == 2 ? '' : dataa[2];

    HttpsCallable func =
        FirebaseFunctions.instance.httpsCallable('notifySubscribers');
    try {
      final HttpsCallableResult res = await func.call(
        <String, dynamic>{
          'targetDevices': deviceToken,
          'messageTitle': messageTitle,
          'messageBody': messageBody,
          'value1': dataa[0],
          'value2': dataa[1],
          'value3': value3,
        },
      );

      if (res.data as bool) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  handleNotification(
      {required BuildContext context, required List<String> keys}) async {
    if (keys[0] == 'usman') {
      Provider.of<AppProvider>(context, listen: false).onTabTapped(2);
    }
  }

  Future<NotificationSettings?> _requestPermission() async {
    try {
      NotificationSettings notificationSettings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        announcement: false,
      );

      return notificationSettings;
    } catch (e) {
      CustomToast.errorToast(
          message: 'Permissions are necessary to show notifications');
    }
    return null;
  }

  //? Not using now
  // ignore: unused_element
  // void _registerForegroundMessageHandler() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
  //     if (remoteMessage.notification != null) {}
  //   });
  // }
}
