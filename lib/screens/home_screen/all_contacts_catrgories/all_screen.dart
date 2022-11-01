import 'package:flutter/material.dart';

import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../empty_screen/empty_screen.dart';
import '../categories/category.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      ],
    );
  }

  Widget allitems(BuildContext context, String name, double width, bool primary,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: width,
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
