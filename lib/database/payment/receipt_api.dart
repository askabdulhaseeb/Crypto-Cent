import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/payment/receipt.dart';

import '../../widgets/custom_widgets/custom_toast.dart';

class ReceiptApi{
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
}