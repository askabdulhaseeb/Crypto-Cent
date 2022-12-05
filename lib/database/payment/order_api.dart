import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/payment/order.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../app_user/auth_method.dart';

class OrderApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'orders';
  Future<bool> add(Order order) async {
    try {
      await _instance
          .collection(_collection)
          .doc(order.orderID)
          .set(order.toMap());
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
