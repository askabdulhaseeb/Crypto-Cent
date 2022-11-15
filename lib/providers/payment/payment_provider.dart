import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../models/cart.dart';
import '../../models/payment/orderd_product.dart';
import '../../models/product_model.dart';

class PaymentProvider with ChangeNotifier {
  final List<OrderdProduct> _orderProduct = <OrderdProduct>[];
  List<OrderdProduct> get orderdProduct => _orderProduct;
  String uid = const Uuid().v4();
  productOrder(List<Product> product, List<Cart> cart) {
    for (int i = 0; i < product.length; i++) {
      OrderdProduct tempOrderProduct = OrderdProduct(
        pid: uid,
        cryptoPrice: cart[i].price,
        exchangeRate: cart[i].exchangeRate,
        quantity: cart[i].quantity,
      );
      _orderProduct.add(tempOrderProduct);  
    }
  }
}
