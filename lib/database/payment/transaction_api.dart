import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/payment/transaction.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../app_user/auth_method.dart';

class TransactionApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'transaction';
  Future<bool> add(Transactions transaction) async {
    try {
      await _instance
          .collection(_collection)
          .doc(transaction.transactionID)
          .set(transaction.toMap());
      // CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<List<Transactions>> get() async {
    List<Transactions> value = <Transactions>[];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection(_collection)
        .where('customer_uid', isEqualTo: AuthMethods.uid)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      value.add(Transactions.fromMap(e.data() ?? {}));
    }
    return value;
  }
}
