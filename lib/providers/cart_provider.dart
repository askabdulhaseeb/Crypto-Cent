import 'package:flutter/cupertino.dart';

import '../database/crypto_wallet/binance_api.dart';
import '../models/cart.dart';
import '../models/product/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Cart> _cartItems = <Cart>[];
  List<Cart> get cartItem => _cartItems;

  void addtocart(Product value, int quantity) async {
    final double exchangeRate = await BinanceApi().btcPrice();
    Cart temp = Cart(
      id: value.pid,
      sellerID: value.uid,
      title: value.productname,
      imageurl: value.prodURL[0].url,
      price: value.amount,
      exchangeRate: exchangeRate,
      quantity: quantity,
    );
    _cartItems.add(temp);
    notifyListeners();
  }

  bool checkExit(Product value) {
    bool temp = false;
    final int index = _indexOfSelectedIndex(value.pid);
    if (index >= 0) {
      temp = true;
    } else {}

    return temp;
  }

  void decreaseProduct(String value) {
    final int index = _indexOfSelectedIndex(value);
    if (index >= 0) {
      _cartItems[index].quantity = _cartItems[index].quantity - 1;
    } else {}

    notifyListeners();
  }

  void removeProduct(String value) {
    _cartItems.removeWhere((Cart element) => element.id == value);
    notifyListeners();
  }

  void addProduct(String value) {
    final int index = _indexOfSelectedIndex(value);
    if (index >= 0) {
      _cartItems[index].quantity = _cartItems[index].quantity + 1;
    } else {}

    notifyListeners();
  }

  int _indexOfSelectedIndex(String testID) {
    return _cartItems.indexWhere((Cart element) => element.id == testID);
  }

  void deleteItem(String id) {
    // ignore: list_remove_unrelated_type
    _cartItems.remove(id);
    notifyListeners();
  }
  void deleteAllItem() {
    // ignore: list_remove_unrelated_type
    _cartItems.clear();
    notifyListeners();
  }

  double totalPrice() {
    double temp = 0;
    for (Cart element in _cartItems) {
      temp += element.quantity * element.price;
    }
    return temp;
  }

  double btcPrice() {
    double temp = 0;
    for (Cart element in _cartItems) {
      temp += element.quantity * element.price;
    }
    return temp;
  }
}
