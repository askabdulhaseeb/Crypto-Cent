import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../database/app_user/user_api.dart';
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
  }) async {
    HttpsCallable func =
        FirebaseFunctions.instance.httpsCallable('notifySubscribers');
    try {
      final HttpsCallableResult res = await func.call(
        <String, dynamic>{
          'targetDevices': deviceToken,
          'messageTitle': messageTitle,
          'messageBody': messageBody,
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
    if (message != null) _handleNotificationData(message.data, context);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationData(message.data, context);
    });
  }

  _handleNotificationData(
      Map<String, dynamic> data, BuildContext context) async {
    print('on click Notification');
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

  // _handleNotificationData(
  //     Map<String, dynamic> data, BuildContext context) async {
  //   print('it is clicked');
  //   switch (data['key1']) {
  //     case 'follow_request':
  //       String uid = data['key2'];
  //       AppUser? user = await UserApi().user(uid: uid);
  //       if (user == null) break;
  //       AppUser? me = await UserApi().user(uid: AuthMethods.uid);
  //       Provider.of<UserProvider>(context, listen: false).refresh();
  //       print('running till now');
  //       // Navigator.push(context,
  //       //     MaterialPageRoute(builder: (_) => OthersProfileScreen(user: user)));
  //       break;
  //     case 'new_post':
  //       String postPid = data['key2'];
  //       SalamSocialPost? post = await SalamSocialAPI().getSpecificPost(postPid);
  //       if (post == null) break;
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (_) => PostFullScreenView(post: post)));
  //       break;
  //     case 'post_comment':
  //       String postPid = data['key2'];
  //       String commentCid = data['key3'];
  //       SalamSocialPost? post = await SalamSocialAPI().getSpecificPost(postPid);
  //       Provider.of<SalamSocialProvider>(context, listen: false)
  //           .setPushNotificationVar(cid: commentCid);
  //       if (post == null) break;
  //       print('all good');
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => PostFullScreenView(
  //             post: post,
  //           ),
  //         ),
  //       );
  //       break;
  //     case 'post_reaction':
  //       String postPid = data['key2'];
  //       SalamSocialPost? post = await SalamSocialAPI().getSpecificPost(postPid);
  //       if (post == null) break;
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => PostFullScreenView(
  //             post: post,
  //             openReactionSreen: true,
  //           ),
  //         ),
  //       );
  //   }
  // }
}
