import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotification =
      BehaviorSubject<String?>();

  static init() async {
    await FlutterLocalNotificationsPlugin().initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel Id', 'channel Name',
            importance: Importance.max),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentBadge: true,
        ));
  }

  static showNotification(
      {required String title,
      required String body,
      int id = 0,
      String? payload}) async {
    await notification.show(
      id,
      title,
      body,
      _notificationDetails(),
      payload: payload,
    );
  }
}
