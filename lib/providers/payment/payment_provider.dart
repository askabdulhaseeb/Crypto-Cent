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

  load() async {
    _order = await OrderApi().get();
    _receipt = await ReceiptApi().get();
    getGraphData();
    print(_order.length);
    print(_receipt.length);
    notifyListeners();
  }

  getGraphData() {
    for (int i = 0; i < _order.length; i++) {
      List<OrderdProduct> temp = _order[i].products;
      for (int j = 0; j < temp.length; j++) {
        totalCount++;
        if (temp[j].status.value == 'pending') {
          proccesing++;
        } else if (temp[j].status.value == 'in_progress') {
          deleviry++;
        } else if (temp[j].status.value == 'completed') {
          completed++;
        } else if (temp[j].status.value == 'cancel') {
          cancel++;
        } else
          shipped++;
      }
    }

    // proccesing = (proccesing / totalCount) * 200;
    // deleviry = (deleviry / totalCount) * 200;
    // completed = (completed / totalCount) * 200;
    // shipped = (shipped / totalCount) * 200;
    // cancel = (cancel / totalCount) * 200;
    // print('pending $proccesing');
    // print('progress $deleviry');
    // print('completed $completed');
    // print('shipped $shipped');
    // print('cancel $cancel');
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

  changeName(String value) {
    tempname = value;
    notifyListeners();
  }

  String tempname = 'All';
  double totalCount = 0;
  double proccesing = 0;
  double completed = 0;
  double deleviry = 0;
  double cancel = 0;
  double shipped = 0;
  final List<OrderdProduct> _orderProduct = <OrderdProduct>[];
  List<OrderdProduct> get orderdProduct => _orderProduct;
  List<Order> _order = <Order>[];
  List<Order> get order => _order;
  List<Receipt> _receipt = <Receipt>[];
  List<Receipt> get receipt => _receipt;
}
