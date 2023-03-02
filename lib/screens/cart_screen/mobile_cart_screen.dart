import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart/empty_cart_widget.dart';
import '../../widgets/cart/fill_cart_widget.dart';
import '../empty_screen/empty_auth_screen.dart';


class MobileCartScreen extends StatelessWidget {
  const MobileCartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return AuthMethods.uid.isEmpty
        ? const EmptyAuthScreen(text: 'Please Log in to view your cart',)
        : Scaffold(
            appBar: AppBar(title: const Text('My Cart')),
            body: cartPro.cartItem.isNotEmpty
                ? const FillCartWidget()
                : const EmptyCartWidget(),
          );
  }
}