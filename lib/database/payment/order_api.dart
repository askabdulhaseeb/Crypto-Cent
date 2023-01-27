import 'package:cloud_firestore/cloud_firestore.dart';

import '../../enum/notification_type.dart';
import '../../models/app_user/app_user.dart';
import '../../models/my_device_token.dart';
import '../../models/payment/order.dart';
import '../../models/product/product_model.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../notification_services.dart';

class OrderApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'orders';
  Future<bool> add({
   required Order order,
    required AppUser sender,
    required List<AppUser> receiver,
    required List<Product> product,
  }) async {
    try {
      await _instance
          .collection(_collection)
          .doc(order.orderID)
          .set(order.toMap());
      for (int i = 0; i < receiver.length; i++) {
        if (receiver[i].deviceToken?.isNotEmpty ?? false) {
          await NotificationsServices().sendSubsceibtionNotification(
            deviceToken: receiver[i].deviceToken ?? <MyDeviceToken>[],
            messageTitle: product[i].productname,
            messageBody: '${sender.name} send you a new order',
            data: <String>['order', 'confirm Order', order.orderID],
            isMessage: false,
            type: NotificationType.confirmOrder,
            fromId: order.customerUID,
            toId: receiver[i].uid,
          );
        }
      }
      // CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<List<Order>> get() async {
    List<Order> orders = <Order>[];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      orders.add(Order.fromMap(e));
    }
    return orders;
  }

  Future<void> updateStatus(Order value) async {
    await _instance
        .collection(_collection)
        .doc(value.orderID)
        .update(value.updateStatus());
  }
}
