import 'package:flutter/cupertino.dart';

import '../database/app_user/auth_method.dart';
import '../database/notification_api.dart';
import '../models/my_notification.dart';

class NotificationProvider with ChangeNotifier {
  List<MyNotification> _notifications = <MyNotification>[];
  List<MyNotification> get notification => _notifications;
  List<MyNotification> _myNotifications = <MyNotification>[];
  List<MyNotification> get myNotification => _myNotifications;
  NotificationProvider() {
    load();
  }
  Future<void> load() async {
    _notifications = await NotificationAPI().getdata();
    myAllNotifications();
    notifyListeners();
  }

  myAllNotifications() {
    for (int i = 0; i < _notifications.length; i++) {
      if (_notifications[i].type.json == 'discount_offer') {
        _myNotifications.add(_notifications[i]);
      } else if (_notifications[i].type.json == 'confirm_order' &&
          (_notifications[i].toUID == AuthMethods.uid ||
              _notifications[i].fromUID == AuthMethods.uid)) {
        _myNotifications.add(_notifications[i]);
      } else if (_notifications[i].type.json == 'delivery_success' &&
          (_notifications[i].toUID == AuthMethods.uid ||
              _notifications[i].fromUID == AuthMethods.uid)) {
        _myNotifications.add(_notifications[i]);
      } else if (_notifications[i].type.json == 'cancel_order' &&
          (_notifications[i].toUID == AuthMethods.uid ||
              _notifications[i].fromUID == AuthMethods.uid)) {
        _myNotifications.add(_notifications[i]);
      } else if (_notifications[i].type.json == 'payment' &&
          (_notifications[i].toUID == AuthMethods.uid ||
              _notifications[i].fromUID == AuthMethods.uid)) {
        _myNotifications.add(_notifications[i]);
      }
    }
  }
}
