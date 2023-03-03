import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../function/crypto_function.dart';
import '../../../models/cart.dart';
import '../../../providers/cart_provider.dart';
import '../../../utilities/utilities.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/cutom_text.dart';
import '../cart_checkout_widget.dart';
import '../tile/cart_tile.dart';

class WebFillCartWidget extends StatelessWidget {
  const WebFillCartWidget({super.key});
  @override
  Widget build(BuildContext context) {
     CartProvider cartProv=Provider.of<CartProvider>(context);
    return ConstrainedBox(
       constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ForText(name: 'Shopping Cart',bold: true,size: 20),
            ForText(name: 'Total ${cartProv.cartItem.length} item',size: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        return CartItem(item: item);
                      },
                    );
                  }),
                ),
                
                // const CartCheckoutWidget(),
            Expanded(
              child: Column(
                children: [
                  ForText(name: 'Order Summary',bold: true,size: 22,),
                   Row(
                  children: <Widget>[
                    const ForText(
                      name: 'Price',
                    ),
                    const Spacer(),
                    ForText(
                      name: 'USD: \$${cartProv.totalPrice()}',
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
                    FutureBuilder<double>(
                        future: CryptoFunction()
                            .btcPrinceLive(dollor: cartProv.totalPrice()),
                        builder: (BuildContext context,
                            AsyncSnapshot<double> exchangeRate) {
                          return ForText(
                            name: exchangeRate.hasError
                                ? '-- ERROR --'
                                : exchangeRate.hasData
                                    ? 'Btc: ${exchangeRate.data!.toStringAsFixed(8)}'
                                    : 'fetching ...',
                            bold: true,
                            size: 16,
                          );
                        }),
                  ],
                ),
                SizedBox(width: 200,
                  child: CustomElevatedButton(title: 'Proceed to Checkout', onTap: (){
                
                  }),
                )
                ],
              ),
            ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
