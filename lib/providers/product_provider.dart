import 'package:flutter/cupertino.dart';

import '../database/local_data.dart';
import '../database/product_api.dart';
import '../models/favorite.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    load();
  }
  List<Product> _product = <Product>[];
  final List<String> _favorites = <String>[];
  List<String> get favorites => _favorites;
  List<Product> get product => _product;
  Future<void> load() async {
    _product = await ProductApi().getdata();
    _favorites.addAll(LocalData.getFavroites);
    notifyListeners();
  }

  List<String> categories = [];

  List<Product> findByCategory(String categoryname) {
    List<Product> _categoryList = _product
        .where((Product element) =>
            element.category.toLowerCase().contains(categoryname.toLowerCase()))
        .toList();
    return _categoryList;
  }

  bool checkfvrt(String value) {
    bool temp = false;
    final int index = _indexOfSelectedIndex(value);
    if (index >= 0) {
      temp = true;
    }
    return temp;
  }

  updateFavorite(String value) {
    if (_favorites.contains(value)) {
      _favorites.remove(value);
    } else {
      _favorites.add(value);
    }
    LocalData.setFavroites(_favorites);
    notifyListeners();
  }

  // void addFvrt(String value) {
  //   final int index = _indexOfSelectedIndex(value);
  //   if (index >= 0) {
  //     print('function chal giya ha');
  //     _fvrt.remove(value);
  //   } else {
  //     Favorite temp = Favorite(uid: value);
  //     _fvrt.add(temp);
  //   }
  //   notifyListeners();
  // }

  int _indexOfSelectedIndex(String value) {
    return _fvrt.indexWhere((Favorite element) => element.uid == value);
  }

  List<Favorite> _fvrt = <Favorite>[];
  List<Favorite> get fvrt => _fvrt;
}
