import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../function/web_appbar.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart/empty/empty_cart_widget.dart';
import '../../widgets/cart/fill/fill_cart_widget.dart';
import '../../widgets/custom_widgets/footer_widget.dart';
import '../empty_screen/empty_auth_screen.dart';


class WebCartScreen extends StatelessWidget {
  const WebCartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return AuthMethods.uid.isEmpty
        ? const EmptyAuthScreen(text: 'Please Log in to view your cart',)
        : Scaffold(
            appBar: WebAppBar().webAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: cartPro.cartItem.isNotEmpty
                      ? const FillCartWidget()
                      : const EmptyCartWidget(),
                ),
                FooterWidget(),
              ],
            ),
          );
  }
}
