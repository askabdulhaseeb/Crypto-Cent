import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/crypto_wallet/binance_api.dart';
import '../../database/payment/order_api.dart';
import '../../database/payment/receipt_api.dart';
import '../../database/payment/transaction_api.dart';
import '../../function/push_notification.dart';
import '../../function/time_date_function.dart';
import '../../function/unique_id_functions.dart';
import '../../models/app_user/app_user.dart';
import '../../models/cart.dart';
import '../../models/my_device_token.dart';
import '../../models/payment/order.dart';
import '../../models/payment/orderd_product.dart';
import '../../models/payment/receipt.dart';
import '../../models/payment/transaction.dart';
import '../../models/product/product_model.dart';
import '../provider.dart';

class PaymentProvider with ChangeNotifier {
  PaymentProvider() {
    load();
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
    _allOrder.clear();
    _receipt.clear();
    _order.clear();
    List<Order> tempOrder = <Order>[];
    tempOrder = await OrderApi().get();
    for (int i = 0; i < tempOrder.length; i++) {
      if (AuthMethods.uid == tempOrder[i].customerUID) {
        _order.add(tempOrder[i]);
      }
    }
    _allOrder = tempOrder;
    _receipt = await ReceiptApi().get();
    getGraphData();
    sellProductFun();
    notifyListeners();
  }

  void sellProductFun() {
    sellProducts.clear();
    sellingOrder.clear();
    for (int i = 0; i < allOrder.length; i++) {
      //print(allOrder[i].orderID);
      for (int j = 0; j < allOrder[i].products.length; j++) {
        // print(allOrder[i].products[j].sellerID);
        // print(AuthMethods.uid);
        if (AuthMethods.uid == allOrder[i].products[j].sellerID) {
          sellProducts.add(allOrder[i].products[j]);
          sellingOrder.add(allOrder[i]);
          print(allOrder[i].products[j].sellerID);
        }
      }
    }
    print(sellProducts.length);
  }

  getGraphData() {
    totalCount = 0;
    proccesing = 0;
    completed = 0;
    deleviry = 0;
    cancel = 0;
    shipped = 0;
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

   List<String> oldCustomer() {
      final List<String> temp = <String>[];
      final String me = AuthMethods.uid;
      final List<Order> tempOrder = _allOrder;
      for (Order element in tempOrder) {
        if (element.sellerUID == me && (!temp.contains(element.sellerUID))) {
          temp.add(element.customerUID);
        }
      }
      return temp;
    }

  Future<bool> productOrder(
    BuildContext context,
    List<Cart> cart,
    List<MyDeviceToken> deviceToken,
  ) async {
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
      timestamp: TimeStamp.timestamp,
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
    print(deviceToken);
    final UserProvider userPro =
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false);
    final AppUser sender = userPro.user(AuthMethods.uid);
    final AppUser receiver = userPro.user(_orderProduct[0].sellerID);
    final bool orderBool = await OrderApi().add(tempOrder);
    final bool receiptBool = await ReceiptApi()
        .add(receipt: tempReceipt, sender: sender, receiver: receiver);
    final bool transactionBool = await TransactionApi().add(tempTransaction);
    orderdProduct.clear();
    if (orderBool && receiptBool && transactionBool) {
      return true;
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
  final List<Order> _order = <Order>[];
  List<Order> get order => _order;
  List<Order> _allOrder = <Order>[];
  List<Order> get allOrder => _allOrder;
  List<Receipt> _receipt = <Receipt>[];
  List<Receipt> get receipt => _receipt;

  final List<Product> _product = <Product>[];
  List<Product> get products => _product;
  final List<Order> _sellingOrder = <Order>[];
  List<Order> get sellingOrder => _sellingOrder;
  final List<OrderdProduct> _sellProduct = <OrderdProduct>[];
  List<OrderdProduct> get sellProducts => _sellProduct;
}
