// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../database/app_user/auth_method.dart';
import '../../providers/app_provider.dart';
import '../../providers/contact_provider.dart';
import '../../providers/user_provider.dart';
import '../../screens/empty_screen/empty_screen.dart';
import '../../screens/category_screens/category.dart';
import '../../screens/product_screens/add_product_screen.dart';
import '../custom_widgets/custom_dialog.dart';
import '../custom_widgets/custom_toast.dart';
import 'contact/contacts_list.dart';
import 'package:flutter/services.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key});
  @override
  Widget build(BuildContext context) {
    ContactProvider contactPro = Provider.of<ContactProvider>(context);
    UserProvider userPro = Provider.of<UserProvider>(context);

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          const SizedBox(width: 16),
          allitems(context, 'All', true, () {}),
          allitems(
              context,
              'Contacts',
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
                  : () async {
                      HapticFeedback.heavyImpact();
                      // await contactPro.loading();
                      await Permission.contacts.request();
                      final bool isOkay = await Permission.contacts.isGranted ||
                          await Permission.contacts.isLimited;
                      bool temp = await contactPro.contactsPermission(context);
                      if (!isOkay) {
                        await openAppSettings();
                        return;
                      }
                      if (temp) {
                        // List<String> bloodoNumber = await userPro.number();
                        bool change = contactPro.loadContacts(userPro.users);
                        if (change) {
                          Navigator.push(
                            context,
                            // ignore: always_specify_types
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ContactList(),
                            ),
                          );
                        }
                      } else {
                        Provider.of<AppProvider>(context, listen: false)
                            .onTabTapped(0);
                        //  Navigator.pop(context);
                        CustomToast.errorToast(message: 'Permission Denied');
                      }
                    }),
          allitems(context, 'Categories', false, () {
            HapticFeedback.heavyImpact();
            Navigator.push(
              context,
              // ignore: always_specify_types
              MaterialPageRoute(
                builder: (BuildContext context) => const CategoryScreen(),
              ),
            );
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
          allitems(context, 'News', false, () {
            HapticFeedback.heavyImpact();
            Navigator.push(
              context,
              MaterialPageRoute<EmptyScreen>(
                builder: (BuildContext context) => const EmptyScreen(),
              ),
            );
          }),
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: (primary)
              ? Theme.of(context).primaryColor
              : Theme.of(context).secondaryHeaderColor,
        ),
        child: Center(
            child: ForText(
          name: name,
          color: (primary) ? Colors.white : Colors.black45,
        )),
      ),
    );
  }
}
