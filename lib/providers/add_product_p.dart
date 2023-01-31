import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/app_user/auth_method.dart';
import '../database/databse_storage.dart';
import '../database/product_api.dart';
import '../function/time_date_function.dart';
import '../function/unique_id_functions.dart';
import '../models/product/product_model.dart';
import '../models/product/product_url.dart';
import '../models/reports/report_product.dart';
import '../screens/empty_screen/empty_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/map_screen/location_screen.dart';
import 'categories_provider.dart';
import 'location_provider.dart';

class AddProductProvider with ChangeNotifier {
  productData(BuildContext context) async {
    isloading = true;
    notifyListeners();
    CategoriesProvider catPro =
        Provider.of<CategoriesProvider>(context, listen: false);
    if (formKey.currentState!.validate() && files[0] != null) {
      final List<ProductURL> urls = <ProductURL>[];
      for (int i = 0; files[i] != null; i++) {
        String imageurl = await Storagemethod().uploadtostorage(
          'post',
          'tester',
          file: files[i],
        );
        urls.add(ProductURL(url: imageurl, isVideo: false, index: i));
      }

      _product = Product(
          pid: UniqueIdFunctions.postID,
          uid: AuthMethods.uid,
          amount: double.parse(amount.text),
          colors: '',
          internationalDelivery: double.parse(internationalDelivery.text),
          localDelivery: double.parse(localDelivery.text),
          quantity: quantity.text,
          productname: productname.text,
          description: productdecription.text,
          timestamp: TimeStamp.timestamp,
          category: catPro.currentCat!.catID,
          subCategory: catPro.subcurrentCat!.catID,
          createdByUID: AuthMethods.uid,
          prodURL: urls,
          locationUID: '',
          reports: <ReportProduct>[]);
      isloading = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        // ignore: always_specify_types
        MaterialPageRoute(
          builder: (BuildContext context) =>
              const LocationScreen(text: 'product upload'),
        ),
      );
      log('enter');
      print(_product!.productname);
    }
  }

  Future<bool> upload(BuildContext context) async {
    isupload = true;
    notifyListeners();
    LocationProvider locationPro =
        Provider.of<LocationProvider>(context, listen: false);
    _product!.locationUID = locationPro.selectLocation.locationID;
    bool temp = await ProductApi().add(product);
    if (temp == true) {
      emptyProduct();
      isupload = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute<MainScreen>(
      //       builder: (BuildContext context) => const MainScreen(),
      //     ),
      //     (Route route) => false);
    }
    return temp;
  }

  emptyProduct() {
    files = <File?>[
      null,
      null,
      null,
      null,
    ];
    _product == _null;
    productname.clear();
    productdecription.clear();
    amount.clear();

    quantity.clear();
    notifyListeners();
  }

  bool isloading = false;
  bool isupload = false;
  Product? _product;
  Product get product => _product!;
  final TextEditingController productname = TextEditingController();
  final TextEditingController productdecription = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController localDelivery = TextEditingController();
  final TextEditingController internationalDelivery = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  List<File?> files = <File?>[
    null,
    null,
    null,
    null,
  ];
  final bool _isloading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product get _null => Product(
      pid: 'null',
      uid: 'null',
      amount: 0,
      internationalDelivery: 0,localDelivery: 0,
      colors: 'null',
      quantity: '0',
      locationUID: '',
      productname: ' ',
      description: 'null',
      timestamp: 0,
      category: 'null',
      subCategory: 'null',
      createdByUID: 'null',
      prodURL: <ProductURL>[],
      reports: <ReportProduct>[]);
}
