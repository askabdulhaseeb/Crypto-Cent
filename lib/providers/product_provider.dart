import 'package:flutter/cupertino.dart';

import '../database/product_api.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    load();
  }
  List<Product> _product = <Product>[];
  List<Product> get product => _product;
  Future<void> load() async {
    _product = await ProductApi().getdata();
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
}
