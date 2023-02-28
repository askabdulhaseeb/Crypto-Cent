import 'package:flutter/material.dart';

import '../../utilities/responsive.dart';
import 'mobile_categories_list.dart';
import 'web_category_list.dart';
class CategoryList extends StatelessWidget {
const CategoryList({super.key});
@override
 Widget build(BuildContext context) {
return const ResponsiveApp(desktop: WebCategoriesList(),
 mobile: MobileCategoriesList(),
  tablet:WebCategoriesList());
}
}