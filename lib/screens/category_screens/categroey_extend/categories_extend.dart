import 'package:flutter/material.dart';
import '../../../utilities/responsive.dart';
import 'mobile_category_extend.dart';
import 'web_category_extend.dart';

// ignore: must_be_immutable
class CategoriesExtend extends StatelessWidget {
  CategoriesExtend({required this.categoryName, super.key});
  String categoryName;

  @override
  Widget build(BuildContext context) {
    
    return ResponsiveApp(
           tablet: MobileCategoryExtend(categoryName: categoryName),
           desktop: WebCategoryExtend(categoryName: categoryName),
           mobile: MobileCategoryExtend(categoryName: categoryName),
      // mobile: _mobileUi(prouctPro, products,width*0.6),
      // tablet: _mobileUi(prouctPro, products,width*0.5),
      // desktop: _desktopUi(prouctPro, products,width*0.2),
    );
  }
}

