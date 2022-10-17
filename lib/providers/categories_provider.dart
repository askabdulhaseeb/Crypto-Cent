import 'package:flutter/cupertino.dart';

import '../database/categories_api.dart';
import '../models/categories/categories.dart';

class CategoriesProvider extends ChangeNotifier {
  CategoriesProvider() {
    load();
  }
  List<Categories> _categories = <Categories>[];

  List<Categories> get categories => <Categories>[..._categories];

  load() async {
    _categories.clear();
    _categories = await CategoriesApi().categories();
  }
}
