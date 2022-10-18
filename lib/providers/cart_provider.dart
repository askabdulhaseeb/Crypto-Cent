import 'package:flutter/cupertino.dart';

import '../models/cart.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Cart> _cartItems = <Cart>[];
  List<Cart> get cartItem => _cartItems;

  void addtocart(Product value, int quantity) {
    Cart temp = Cart(
        id: value.pid,
        title: value.productname,
        imageurl: value.imageurl,
        price: value.amount,
        quantity: quantity);

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

  void removeProduct(Product value) {
    final int index = _indexOfSelectedIndex(value.pid);
    if (index >= 0) {
      _cartItems[index].quantity = _cartItems[index].quantity - 1;
    } else {}

    notifyListeners();
  }

  void addProduct(Product value) {
    print('Enter Ho giya');
    final int index = _indexOfSelectedIndex(value.pid);
    if (index >= 0) {
      _cartItems[index].quantity = _cartItems[index].quantity + 1;
    } else {}

    notifyListeners();
  }

  int _indexOfSelectedIndex(String testID) {
    return _cartItems.indexWhere((Cart element) => element.id == testID);
  }
}
