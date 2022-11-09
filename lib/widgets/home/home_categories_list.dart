import 'package:flutter/material.dart';

import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../screens/empty_screen/empty_screen.dart';
import '../../screens/category_screens/category.dart';
import '../../screens/product_screens/add_product_screen.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          allitems(context, 'All', 80, true, () {}),
          allitems(context, 'Contacts', 120, false, () {
            Navigator.push(
              context,
              // ignore: always_specify_types
              MaterialPageRoute(
                builder: (BuildContext context) => const EmptyScreen(),
              ),
            );
          }),
          allitems(context, 'Categories', 120, false, () {
            Navigator.push(
              context,
              // ignore: always_specify_types
              MaterialPageRoute(
                builder: (BuildContext context) => const CategoryScreen(),
              ),
            );
          }),
          allitems(context, 'Sell', 80, false, () {
            Navigator.push(
              context,
              MaterialPageRoute<AddProductScreen>(
                builder: (BuildContext context) => const AddProductScreen(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget allitems(BuildContext context, String name, double width, bool primary,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: (primary)
              ? Theme.of(context).primaryColor
              : Theme.of(context).secondaryHeaderColor,
        ),
        child: Center(
            child: ForText(
          name: name,
          color: (primary) ? Colors.white : Colors.black38,
        )),
      ),
    );
  }
}
