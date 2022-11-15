import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../database/app_user/auth_method.dart';
import '../../function/time_date_function.dart';
import '../../models/cart.dart';
import '../../models/payment/order.dart';
import '../../models/payment/orderd_product.dart';
import '../../models/payment/receipt.dart';
import '../../models/payment/transaction.dart';
import '../../models/product_model.dart';

class PaymentProvider with ChangeNotifier {
  final List<OrderdProduct> _orderProduct = <OrderdProduct>[];
  List<OrderdProduct> get orderdProduct => _orderProduct;
  String uid = const Uuid().v4();
  productOrder(List<Product> product, List<Cart> cart, double total) {
    for (int i = 0; i < product.length; i++) {
      OrderdProduct tempOrderProduct = OrderdProduct(
        pid: cart[i].id,
        sellerID: cart[i].createdID,
        cryptoPrice: cart[i].price,
        exchangeRate: cart[i].exchangeRate,
        quantity: cart[i].quantity,
      );
      _orderProduct.add(tempOrderProduct);
      Order tempOrder = Order(
          orderID: uid,
          receiptID: uid,
          customerUID: AuthMethods.uid,
          products: _orderProduct);
      Receipt tempReceipt = Receipt(
        receiptID: uid,
        customerUID: AuthMethods.uid,
        timestamp: TimeStamp.timestamp,
        exchangeRate: cart[i].exchangeRate,
        totalCrypto: total,
      );
      Transaction tempTransaction = Transaction(
        transactionID: uid,
        products: _orderProduct,
        orderID: uid,
        buyerID: AuthMethods.uid,
        sellerID: cart[i].createdID,
        timeStamp: TimeStamp.timestamp,
        exchangeRate: cart[i].exchangeRate,
        cryptoSymbol: 'btc',
        totalCryptoPrice: total,
      );
    }
  }
}
