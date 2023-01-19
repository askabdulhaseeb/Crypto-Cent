import 'package:flutter/cupertino.dart';

import '../database/local_data.dart';
import '../database/product_api.dart';
import '../models/product/product_model.dart';
import '../models/product/product_url.dart';
import '../models/reports/report_product.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    load();
  }
  List<Product> _product = <Product>[];
  final List<String> _favorites = <String>[];
  List<String> get favorites => _favorites;
  List<Product> get products => _product;

  Future<void> load() async {
    _product = await ProductApi().getdata();
    _favorites.addAll(LocalData.getFavroites);
    notifyListeners();
  }

  Product product(String value) {
    final int index =
        _product.indexWhere((Product element) => element.pid == value);
    return index < 0 ? _null : _product[index];
  }

  // ignore: always_specify_types
  List<String> categories = [];

  List<Product> findByCategory(String categoryname) {
    List<Product> categoryList = _product
        .where((Product element) =>
            element.category.toLowerCase().contains(categoryname.toLowerCase()))
        .toList();
    return categoryList;
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

  String? _search;
  onSearch(String? value) {
    _search = value;
    notifyListeners();
  }

  List<Product> forSearch() {
    final List<Product> temp = <Product>[];
    for (Product element in _product) {
      if (_search == null || (_search?.isEmpty ?? true)) {
        temp.add(_null);
      } else if (element.productname
          .toLowerCase()
          .startsWith((_search?.toLowerCase() ?? ''))) {
        temp.add(element);
      }
    }
    return temp;
  }

  Future<void> report(Product product) async {
    final int index =
        _product.indexWhere((Product element) => element.pid == product.pid);
    if (index < 0) return;
    _product[index] = product;
    notifyListeners();
    await ProductApi().report(product);
  }

  Product get _null => Product(
      pid: 'null',
      uid: 'null',
      amount: 0,
      colors: 'null',
      quantity: '0',
      productname: ' ',
      description: 'null',
      timestamp: 0,
      category: 'null',
      subCategory: 'null',
      createdByUID: 'null',
      prodURL: <ProductURL>[],
      reports: <ReportProduct>[]);
}
