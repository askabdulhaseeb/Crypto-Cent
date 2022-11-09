import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../screens/order/payment.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/cutom_text.dart';

class CartCheckoutWidget extends StatelessWidget {
  const CartCheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (
      BuildContext context,
      CartProvider cartPro,
      _,
    ) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(PaymentScreen.routes);
        },
        child: Container(
          height: 210,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                const Divider(),
                Row(
                  children: <Widget>[
                    const ForText(name: 'Select Item'),
                    const Spacer(),
                    ForText(
                      name: cartPro.cartItem.length.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const ForText(
                      name: 'Price',
                    ),
                    const Spacer(),
                    ForText(
                      name: cartPro.totalPrice().toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const <Widget>[
                    ForText(name: 'Discount'),
                    Spacer(),
                    ForText(
                      name: '0',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const ForText(
                      name: 'Total Price',
                      bold: true,
                      size: 16,
                    ),
                    const Spacer(),
                    ForText(
                      name: '\$${cartPro.totalPrice()}',
                      bold: true,
                      size: 16,
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                    height: 60,
                    child: CustomElevatedButton(
                        title: 'Check out',
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: always_specify_types
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PaymentScreen(),
                            ),
                          );
                        })),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      );
    });
  }
}
