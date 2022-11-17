import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/payment/receipt.dart';

import '../../widgets/custom_widgets/custom_toast.dart';
import '../app_user/auth_method.dart';

class ReceiptApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'receipt';
  Future<bool> add(Receipt receipt) async {
    try {
      await _instance
          .collection(_collection)
          .doc(receipt.receiptID)
          .set(receipt.toMap());
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
