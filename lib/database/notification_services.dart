import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsServices {
  static final FlutterLocalNotificationsPlugin localNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('launch_background');
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
    await localNotificationPlugin.initialize(
      initializationSettings,
      //     onSelectNotification: (String? payload) async {
      //   debugPrint('notification payload: ' + payload!);
      // }
    );

    tz.initializeTimeZones();
    final String locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));

    await localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> scheduleAzanNotification(DateTime prayerTime,
      String prayerName, int notificationId, int azanSoundIndex) async {
    if (prayerTime.isAfter(DateTime.now())) {
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'alarm_notif$azanSoundIndex',
        'alarm_notif$azanSoundIndex',
        channelDescription: 'Channel for Alarm notification',
        icon: 'app_icon',
        sound: RawResourceAndroidNotificationSound('azan$azanSoundIndex'),
        largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
        playSound: true,
        importance: Importance.max,
        priority: Priority.max,
      );

      DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
        sound: 'azan$azanSoundIndex.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      NotificationDetails platformSpecificDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await init();

      await localNotificationPlugin.zonedSchedule(
        notificationId,
        'Salamgram',
        'Reminder for $prayerName prayer',
        tz.TZDateTime.from(prayerTime, tz.local),
        platformSpecificDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel Id', 'channel Name',
          importance: Importance.max),
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
    String? payload,
  }) async {
    await localNotificationPlugin.show(id, title, body, _notificationDetails());
  }

  static Future<void> cancelNotification(int id) async {
    await localNotificationPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await localNotificationPlugin.cancelAll();
  }
}
