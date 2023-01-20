import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import '../models/app_user/app_user.dart';
import '../models/my_device_token.dart';
import '../providers/user_provider.dart';
import '../utilities/utilities.dart';
import 'app_user/auth_method.dart';
import 'app_user/user_api.dart';

class NotificationsServices {
  static final FlutterLocalNotificationsPlugin localNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotification =
      BehaviorSubject<String?>();
  static Future<void> init() async {
    log('NOTIFICATION INIT START');
    await Permission.notification.request();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            defaultPresentSound: true,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // await localNotificationPlugin.initialize(initializationSettings);
    await FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        onNotification.add(details.payload);

        print('notification payload :${details.payload!} ');
        // print('notification id :${details.id} ');
        print('notification payload :${details.id} ');
        print('notification payload :${details.payload} ');
        // print('notification input :${details.input} ');
        // print('notification action id :${details.actionId} ');
        // print('notification type  :${details.notificationResponseType.name} ');
        // print('notification detail :${details.toString()} ');

        // if (details.id == 1) {
        //   print('1 chala ha');
        // }
      },
      //     onSelectNotification: (String? payload) async {
      //   debugPrint('notification payload: ' + payload!);
      // }
    );

    // tz.initializeTimeZones();
    // final String locationName = await FlutterNativeTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(locationName));

    await localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        _notificationDetails();
        showNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          // payload: message.data['key1'] +
          //     '-' +
          //     message.data['key2'] +
          //     '-' +
          //     message.data['key3'],
          payload: '',
        );
        // print('Message also contained a notification: ${message.notification}');
      }
    });
    log('NOTIFICATION INIT DONE');
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel Id', 'channel Name',
          playSound: true, importance: Importance.max),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      ),
    );
  }

  static showNotification({
    required String title,
    required String body,
    int id = 0,
    required String payload,
  }) async {
    await localNotificationPlugin.show(id, title, body, _notificationDetails(),
        payload: payload);
  }

  Future<bool> sendSubsceibtionNotification({
    required List<MyDeviceToken> deviceToken,
    required String messageTitle,
    required String messageBody,
    required List<String> data,
  }) async {
    // String value3 = data.length == 2 ? '' : data[2];
    // HttpsCallable func =
    //     FirebaseFunctions.instance.httpsCallable('notifySubscribers');
    // // ignore: always_specify_types
    // final HttpsCallableResult res = await func.call(
    //   <String, dynamic>{
    //     'targetDevices': deviceToken,
    //     'messageTitle': messageTitle,
    //     'messageBody': messageBody,
    //     'value1': data[0],
    //     'value2': data[1],
    //     'value3': value3,
    //   },
    // );
    // if (res.data as bool) {
    //   return true;
    try {
      for (int i = 0; i < deviceToken.length; i++) {
        log('Receiver Devive Token: ${deviceToken[i].token}');
        final Map<String, String> headers = <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${Utilities.firebaseServerID}',
        };
        final http.Request request = http.Request(
          'POST',
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
        );
        request.body = json.encode(<String, dynamic>{
          'to': deviceToken[i].token,
          'priority': 'high',
          'notification': <String, String>{
            'body': messageBody,
            'title': messageTitle,
          }
        });
        request.headers.addAll(headers);
        final http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
          log('Notification send to: ${deviceToken[i].token}');
        } else {
          log('ERROR in FCM');
        }
      }
      return true;
    } catch (e) {
      log('ERROR in FCM: ${e.toString()}');
      return false;
    }
  }

  static Future<void> cancelNotification(int id) async {
    await localNotificationPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await localNotificationPlugin.cancelAll();
  }

  Future<void> verifyTokenIsUnique({
    required List<AppUser> allUsersValue,
    required String deviceTokenValue,
  }) async {
    final String meUID = AuthMethods.uid;
    for (AppUser element in allUsersValue) {
      if (tokenAlreadyExist(
              devicesValue: (element.deviceToken ?? <MyDeviceToken>[]),
              tokenValue: deviceTokenValue) &&
          element.uid != meUID) {
        element.deviceToken?.removeWhere(
            (MyDeviceToken element) => element.token == deviceTokenValue);
        await UserApi()
            .setDeviceToken(element.deviceToken ?? <MyDeviceToken>[]);
      }
    }
  }

  bool tokenAlreadyExist({
    required List<MyDeviceToken> devicesValue,
    required String tokenValue,
  }) {
    log(tokenValue);
    for (MyDeviceToken element in devicesValue) {
      print(element.token);
      if (element.token == tokenValue) return true;
    }
    return false;
  }

  onLogin(BuildContext context) async {
    final UserProvider userPro =
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false);
    userPro.refresh();
    final String? token = await FirebaseMessaging.instance.getToken();
    final AppUser me = userPro.user(AuthMethods.uid);
    final bool exist = NotificationsServices().tokenAlreadyExist(
        devicesValue: me.deviceToken ?? <MyDeviceToken>[],
        tokenValue: token ?? '');
    if (!exist) {
      me.deviceToken?.add(MyDeviceToken(token: token ?? ''));
      me.deviceToken
          ?.removeWhere((MyDeviceToken element) => element.token.isEmpty);
      await UserApi().setDeviceToken(me.deviceToken ?? <MyDeviceToken>[]);
      await NotificationsServices().verifyTokenIsUnique(
        allUsersValue: userPro.users,
        deviceTokenValue: token ?? '',
      );
    }
  }
}
