import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product/product_model.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class ProductApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'post';
  Future<bool> add(Product product) async {
    try {
      await _instance
          .collection(_collection)
          .doc(product.pid)
          .set(product.toMap());
      // CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<List<Product>> getdata() async {
    List<Product> product = <Product>[];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      product.add(Product.fromMap(e));
    }
    return product;
  }

  Future<bool> report(Product product) async {
    try {
      final Map<String, dynamic>? value = product.report();
      if (value == null) return false;
      // ignore: always_specify_types
      await _instance.collection(_collection).doc(product.pid).update(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
