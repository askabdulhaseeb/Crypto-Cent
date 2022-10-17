import 'package:flutter/cupertino.dart';

import '../database/categories_api.dart';
import '../models/categories/categories.dart';

class CategoriesProvider extends ChangeNotifier {
  CategoriesProvider() {
    _load();
  }
  List<Categories> _categories = <Categories>[];

  List<Categories> get categories => <Categories>[..._categories];

  _load() async {
    _categories = await CategoriesApi().categories();
  }
}
