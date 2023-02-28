// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../function/web_appbar.dart';
import '../../providers/categories_provider.dart';
import '../../utilities/responsive.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import 'categroey_extend/categories_extend.dart';
import 'mobile_category_screen.dart';
import 'web_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const String routeName = '/category-screen';

  @override
  Widget build(BuildContext context) {
    CategoriesProvider catPro = Provider.of<CategoriesProvider>(context);
    return const ResponsiveApp(
      mobile: MobileCatgoryScreen(),
      tablet:WebCategoryScreen(),
      desktop:WebCategoryScreen() ,
    );
  }


}


