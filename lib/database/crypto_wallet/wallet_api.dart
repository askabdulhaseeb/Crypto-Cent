import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/crypto_wallet/wallet.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class WalletsApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'wallets';
  Future<bool> add(Wallets wallets) async {
    try {
      await _instance
          .collection(_collection)
          .doc(wallets.walletId)
          .set(wallets.toMap());
      //CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<List<Wallets>> get() async {
    List<Wallets> wallets = <Wallets>[];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _instance.collection(_collection).get();
      for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
        wallets.add(Wallets.fromMap(e));
        
      }
      //CustomToast.successToast(message: 'Success');
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return wallets;
  }
}
