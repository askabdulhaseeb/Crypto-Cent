import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/cart/empty_cart_widget.dart';
import '../../widgets/cart/fill_cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cartPro.cartItem.isNotEmpty
          ? const FillCartWidget()
          : const EmptyCartWidget(),
    );
  }
}
