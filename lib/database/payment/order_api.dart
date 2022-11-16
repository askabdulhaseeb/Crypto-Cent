import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/payment/order.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class OrderApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'orer';
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
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _instance.collection(_collection).get();
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      orders.add(Order.fromMap(e));
    }
    return orders;
  }
}
