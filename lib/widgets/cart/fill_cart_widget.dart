import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../providers/cart_provider.dart';
import 'cart_checkout_widget.dart';
import 'cart_tile.dart';

class FillCartWidget extends StatelessWidget {
  const FillCartWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Consumer<CartProvider>(builder: (
            BuildContext context,
            CartProvider cartPro,
            _,
          ) {
            final List<Cart> cart = cartPro.cartItem;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: cart.length,
              itemBuilder: (BuildContext context, int index) {
                final Cart item = cart[index];
                return CartItems(item: item);
              },
            );
          }),
        ),
        const CartCheckoutWidget(),
      ],
    );
  }
}
