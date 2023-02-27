import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/cutom_text.dart';
import '../../widgets/home/web_category_list.dart';
import '../../widgets/product/latest_product.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ForText(
            name: 'Browse',
            bold: true,
            size: 20,
          ),
        ),
        const WebCategoriesList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const ForText(
                name: 'Popular Products',
                bold: true,
                size: 18,
              ),
              TextButton(
                onPressed: (() {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute<CategoriesExtend>(
                  //         builder: (BuildContext context) =>
                  //             CategoriesExtend(categoryName: 'All')));
                }),
                child: ForText(
                  name: 'View All',
                  color: Theme.of(context).primaryColor,
                  bold: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LatestProductsList(),
        ),
      ],
    );
  }
}
