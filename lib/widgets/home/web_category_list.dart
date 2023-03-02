// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../database/app_user/auth_method.dart';
import '../../screens/empty_screen/empty_screen.dart';
import '../../screens/category_screens/category.dart';
import '../../screens/product_screens/add_product_screen.dart';
import '../custom_widgets/custom_dialog.dart';
import 'contact/contacts_list.dart';
import 'package:flutter/services.dart';

class WebCategoriesList extends StatelessWidget {
  const WebCategoriesList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          const SizedBox(width: 16),
          allitems(context, 'All', true, () {}),
          allitems(context, 'Categories', false, () {
            HapticFeedback.heavyImpact();
            Navigator.of(context).pushNamed(CategoryScreen.routeName);
          }),
          allitems(
              context,
              'Sell',
              false,
              (AuthMethods.uid.isEmpty)
                  ? () {
                      HapticFeedback.heavyImpact();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox(
                              title: 'To enable this function',
                              descriptions: 'Please login or create account ',
                              text: 'Login',
                            );
                          });
                    }
                  : () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute<AddProductScreen>(
                          builder: (BuildContext context) =>
                              const AddProductScreen(),
                        ),
                      );
                    }),
          // allitems(context, 'News', false, () {
          //   HapticFeedback.heavyImpact();
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute<EmptyScreen>(
          //       builder: (BuildContext context) => const EmptyScreen(),
          //     ),
          //   );
          // }),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget allitems(
      BuildContext context, String name, bool primary, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).primaryColor),
        child: Center(
            child: ForText(
          name: name,
          color: Colors.black,
        )),
      ),
    );
  }
}