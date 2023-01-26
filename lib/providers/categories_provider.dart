import 'package:flutter/cupertino.dart';

import '../database/categories_api.dart';
import '../models/categories/categories.dart';
import '../models/categories/sub_categories.dart';

class CategoriesProvider with ChangeNotifier {
  CategoriesProvider() {
    load();
  }
  List<Categories> _categories = <Categories>[];

  List<Categories> get categories => <Categories>[..._categories];
  final List<Categories> _someCategories = <Categories>[];

  List<Categories> get someCategories => <Categories>[..._someCategories];

  load() async {
    _categories.clear();
    _categories = await CategoriesApi().categories();
    for (int i = 0; i < _categories.length; i++) {
      if (_categories[i].title == 'Cars/vehicles') {
        _someCategories.add(_categories[i]);
      } else if (_categories[i].title == 'Electronics') {
        _someCategories.add(_categories[i]);
      } else if (_categories[i].title == 'Mobile phones') {
        _someCategories.add(_categories[i]);
      } else if (_categories[i].title == 'Sport') {
        _someCategories.add(_categories[i]);
      }
    }
    _currentCat = _categories[0];
    _subCa = _categories[0].subCategories;
    _subcurrentCat = _categories[0].subCategories[0];
    notifyListeners();
  }

  Categories? _currentCat;
  Categories? get currentCat => _currentCat;
  formValueChange(Categories value) {
    _currentCat = value;
    _subcurrentCat = _currentCat!.subCategories[0];
    _subCa = _currentCat!.subCategories;
    notifyListeners();
  }

  subCategoryChange(SubCategory value) {
    _subcurrentCat = value;
    notifyListeners();
  }

  List<SubCategory> _subCa = <SubCategory>[];

  List<SubCategory> get subCa => <SubCategory>[..._subCa];
  SubCategory? _subcurrentCat;
  SubCategory? get subcurrentCat => _subcurrentCat;
  String? _search;
  onSearch(String? value) {
    _search = value;
    notifyListeners();
  }

  List<String> forSearch() {
    final List<String> temp = <String>[];
    for (Categories element in _categories) {
      if (_search == null || (_search?.isEmpty ?? true)) {
        temp.add('');
      } else if (element.title
          .toLowerCase()
          .startsWith((_search?.toLowerCase() ?? ''))) {
        temp.add(element.title);
      }
    }
    return temp;
  }
}
