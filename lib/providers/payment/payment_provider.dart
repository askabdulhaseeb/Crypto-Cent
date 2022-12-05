import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/crypto_wallet/binance_api.dart';
import '../../database/payment/order_api.dart';
import '../../database/payment/receipt_api.dart';
import '../../database/payment/transaction_api.dart';
import '../../function/time_date_function.dart';
import '../../function/unique_id_functions.dart';
import '../../models/cart.dart';
import '../../models/payment/order.dart';
import '../../models/payment/orderd_product.dart';
import '../../models/payment/receipt.dart';
import '../../models/payment/transaction.dart';
import '../../models/product/product_model.dart';
import '../product_provider.dart';

class PaymentProvider with ChangeNotifier {
  PaymentProvider() {
    load();
  }
  update(ProductProvider value) {
    _product = value.products;
    notifyListeners();
  }

  Product? getproduct(String value) {
    Product temp;
    for (int i = 0; i < _product.length; i++) {
      if (value == _product[i].pid) {
        return _product[i];
      }
    }
    return null;
  }

  load() async {
    List<Order> tempOrder = <Order>[];
    tempOrder = await OrderApi().get();
    for (int i = 0; i < tempOrder.length; i++) {
      if (AuthMethods.uid == tempOrder[i].customerUID) {
        _order.add(tempOrder[i]);
      }
    }

    _receipt = await ReceiptApi().get();
    getGraphData();
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
        } else {
          shipped++;
        }
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

  Future<bool> productOrder(List<Cart> cart) async {
    String uniqueID = UniqueIdFunctions.postID;
    bool retBool = false;
    final double exchangeRate = await BinanceApi().btcPrice();
    double total = 0;
    for (int i = 0; i < cart.length; i++) {
      OrderdProduct tempOrderProduct = OrderdProduct(
        pid: cart[i].id,
        sellerID: cart[i].sellerID,
        localAmount: cart[i].price,
        exchangeRate: exchangeRate,
        quantity: cart[i].quantity,
      );
      total += cart[i].price * cart[i].quantity;
      _orderProduct.add(tempOrderProduct);
    }
    Order tempOrder = Order(
      orderID: uniqueID,
      receiptID: uniqueID,
      sellerUID: _orderProduct[0].sellerID,
      customerUID: AuthMethods.uid,
      timestamp: 0,
      products: _orderProduct,
    );
    Receipt tempReceipt = Receipt(
      receiptID: uniqueID,
      customerUID: AuthMethods.uid,
      sellerUID: _orderProduct[0].sellerID,
      timestamp: TimeStamp.timestamp,
      exchangeRate: exchangeRate,
      totalLocalAmount: total,
    );
    Transactions tempTransaction = Transactions(
      transactionID: uniqueID,
      products: _orderProduct,
      orderID: uniqueID,
      customerUID: AuthMethods.uid,
      sellerUID: _orderProduct[0].sellerID,
      timeStamp: TimeStamp.timestamp,
      exchangeRate: exchangeRate,
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
        log('data Upload Succefully');
      }
      return retBool;
    }
    return false;
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

  List<Product> _product = <Product>[];
  List<Product> get products => _product;
}
