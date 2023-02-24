import 'package:cloud_firestore/cloud_firestore.dart';

import '../../enum/notification_type.dart';
import '../../models/app_user/app_user.dart';
import '../../models/my_device_token.dart';
import '../../models/payment/receipt.dart';

import '../../widgets/custom_widgets/custom_toast.dart';
import '../app_user/auth_method.dart';
import '../notification_services.dart';

class ReceiptApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'receipt';
  Future<bool> add({
    required Receipt receipt,
    required AppUser sender,
    required AppUser receiver,
  }) async {
    try {
      await _instance
          .collection(_collection)
          .doc(receipt.receiptID)
          .set(receipt.toMap());
      // if (receiver.deviceToken?.isNotEmpty ?? false) {
      //   await NotificationsServices().sendSubsceibtionNotification(
      //     deviceToken: receiver.deviceToken ?? <MyDeviceToken>[],
      //     messageTitle: 'New MyOrder',
      //     messageBody: '${sender.name} send you a new order',
      //     data: <String>['order', 'receipt', receipt.receiptID],
      //     isMessage: false,
      //     type: NotificationType.deliverySuccess,
      //     fromId: AuthMethods.uid,
      //     toId: receiver.uid,
      //   );
      // }
      // CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<List<Receipt>> get() async {
    List<Receipt> value = <Receipt>[];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection(_collection)
        .where('customer_uid', isEqualTo: AuthMethods.uid)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      value.add(Receipt.fromMap(e));
    }
    return value;
  }
}
