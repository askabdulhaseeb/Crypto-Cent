import 'package:cloud_firestore/cloud_firestore.dart';

import '../enum/notification_type.dart';
import '../models/my_notification.dart';
import '../widgets/custom_widgets/custom_toast.dart';
import 'app_user/auth_method.dart';

class NotificationAPI {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'notifications';
  sendNotification(MyNotification value) async {
    if (value.toUID == AuthMethods.uid) return;
    await _instance
        .collection(_collection)
        .doc(value.notificationID)
        .set(value.toMap());
  }

  Future<List<MyNotification>> notificationsOfType(
      NotificationType type) async {
    final List<MyNotification> notice = <MyNotification>[];
    try {
      final QuerySnapshot<Map<String, dynamic>> docs = await _instance
          .collection(_collection)
          .where('to_uid', isEqualTo: AuthMethods.uid)
          .where('type', isEqualTo: type.json)
          .orderBy('timestamp')
          .get();
      if (docs.docs.isEmpty) notice;
      for (DocumentSnapshot<Map<String, dynamic>> element in docs.docs) {
        notice.add(MyNotification.fromDoc(element));
      }
    } catch (e) {
     
      CustomToast.errorToast(message: e.toString());
    }
    return notice;
  }
}
