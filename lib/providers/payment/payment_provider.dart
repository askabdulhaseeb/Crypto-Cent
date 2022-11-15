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
  final List<OrderdProduct> _orderProduct = <OrderdProduct>[];
  List<OrderdProduct> get orderdProduct => _orderProduct;
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
      Transactions tempTransaction = Transactions(
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
      final bool orderBool = await OrderApi().add(tempOrder);
      final bool receiptBool = await ReceiptApi().add(tempReceipt);
      final bool transactionBool = await TransactionApi().add(tempTransaction);
      if (orderBool && receiptBool && transactionBool) {
        retBool = true;
        if (kDebugMode) {
          print('data Upload Succefully');
        }
      }
      return retBool;
    }
  }
}
