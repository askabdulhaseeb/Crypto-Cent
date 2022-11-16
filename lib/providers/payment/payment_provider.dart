import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/payment/order_api.dart';
import '../../database/payment/receipt_api.dart';
import '../../database/payment/transaction_api.dart';
import '../../function/time_date_function.dart';
import '../../models/cart.dart';
import '../../models/payment/order.dart';
import '../../models/payment/orderd_product.dart';
import '../../models/payment/receipt.dart';
import '../../models/payment/transaction.dart';

class PaymentProvider with ChangeNotifier {
  PaymentProvider() {
    load();
  }
  final List<OrderdProduct> _orderProduct = <OrderdProduct>[];
  List<OrderdProduct> get orderdProduct => _orderProduct;
  List<Order> _order = <Order>[];
  List<Order> get order => _order;
  load() async {
    _order = await OrderApi().get();
    print(_order.length);
    notifyListeners();
  }

  String uid = const Uuid().v4();
  Future<bool?> productOrder(List<Cart> cart, double total) async {
    bool retBool = false;
    for (int i = 0; i < cart.length; i++) {
      OrderdProduct tempOrderProduct = OrderdProduct(
        pid: cart[i].id,
        sellerID: cart[i].createdID,
        cryptoPrice: cart[i].price,
        exchangeRate: cart[i].exchangeRate,
        quantity: cart[i].quantity,
      );
      _orderProduct.add(tempOrderProduct);
    }
    Order tempOrder = Order(
        orderID: uid,
        receiptID: uid,
        customerUID: AuthMethods.uid,
        products: _orderProduct);
    Receipt tempReceipt = Receipt(
      receiptID: uid,
      customerUID: AuthMethods.uid,
      timestamp: TimeStamp.timestamp,
      exchangeRate: cart[0].exchangeRate,
      totalCrypto: total,
    );
    Transactions tempTransaction = Transactions(
      transactionID: uid,
      products: _orderProduct,
      orderID: uid,
      buyerID: AuthMethods.uid,
      timeStamp: TimeStamp.timestamp,
      exchangeRate: cart[0].exchangeRate,
      cryptoSymbol: 'btc',
      totalCryptoPrice: total,
    );
    final bool orderBool = await OrderApi().add(tempOrder);
    final bool receiptBool = await ReceiptApi().add(tempReceipt);
    final bool transactionBool = await TransactionApi().add(tempTransaction);
    orderdProduct.clear();
    if (orderBool && receiptBool && transactionBool) {
      retBool = true;
      if (kDebugMode) {
        print('data Upload Succefully');
      }

      return retBool;
    }
  }
}
