import 'dart:core';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/app_user/user_api.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class PushNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final PushNotification instance = PushNotification();

  String? _token;
  String? get token => _token;

  Future<List<String>?>? init({required List<String> devicesToken}) async {
    final NotificationSettings? settings = await _requestPermission();

    if (settings!.authorizationStatus == AuthorizationStatus.authorized) {}

    if (settings != null &&
        (settings.authorizationStatus == AuthorizationStatus.provisional ||
            settings.authorizationStatus == AuthorizationStatus.authorized)) {
      List<String>? updatedDevicesToken = await _getToken(devicesToken);
      if (updatedDevicesToken != null && updatedDevicesToken.isNotEmpty) {
        return updatedDevicesToken;
      }
    } else {
      CustomToast.errorToast(
          message: 'Permissions are neccessary for notifications');
    }
    return null;
  }

  Future<List<String>?>? _getToken(List<String> devicesToken) async {
    _token = await _firebaseMessaging.getToken();
    if (_token == null) {
      CustomToast.errorToast(message: 'Unable to fetch Data, Tryagain Later');
      return null;
    }

    if (devicesToken.contains(_token)) return null;
    devicesToken.add(_token!);
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
      // ignore: always_specify_types
      final HttpsCallableResult res = await func.call(
        <String, dynamic>{
          'targetDevices': deviceToken,
          'messageTitle': messageTitle,
          'messageBody': messageBody,
          //'body': messageBody,
          // 'messageBodyLocArgs': dataa,
          'value1': dataa[0],
          'value2': dataa[1],
          'value3': value3,
        },
      );
      print(res.data);
      if (res.data as bool) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  handleNotification(BuildContext context) async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    print('idr a giya ha');
    //print('message data  ${message!.data.length}');
    if (message != null) {
      print(message.data['key1']);
      print(message.data['value1']);
    }
    if (message != null) _handleNotificationData(message.data, context);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationData(message.data, context);
    });
  }

  _handleNotificationData(
      Map<String, dynamic> data, BuildContext context) async {
    print('on click Notification');
    if (data['value1'] == 'post') {
      print('post2');
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
