import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:provider/provider.dart';
>>>>>>> fc69de18b8d55a7269b8c097e257741938683c93

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
    required List<String> data,
  }) async {
    String value3 = data.length == 2 ? '' : data[2];
    log(data[0]);
    log(data[1]);
    log(data[2]);
    HttpsCallable func =
        FirebaseFunctions.instance.httpsCallable('notifySubscribers');
    try {
      final HttpsCallableResult res = await func.call(
        <String, dynamic>{
          'targetDevices': deviceToken,
          'messageTitle': messageTitle,
          'messageBody': messageBody,
          'value1': data[0],
          'value2': data[1],
<<<<<<< HEAD
          'value3': value3,
=======
>>>>>>> fc69de18b8d55a7269b8c097e257741938683c93
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

  handleNotification(BuildContext context) async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
<<<<<<< HEAD
    print('message main aya ha');
    if (message != null) _handleNotificationData(message.data, context);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message listen');
      _handleNotificationData(message.data, context);
    });
  }
=======
    if (message != null) _handleNotificationData(message.data, context);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
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
>>>>>>> fc69de18b8d55a7269b8c097e257741938683c93

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

  _handleNotificationData(
      Map<String, dynamic> data, BuildContext context) async {
    print('it is clicked');
    print(data['key1']);
  }
}
