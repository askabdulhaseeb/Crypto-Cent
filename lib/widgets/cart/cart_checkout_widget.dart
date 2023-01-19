import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../function/crypto_function.dart';
import '../../providers/cart_provider.dart';
import '../../screens/map_screen/location_screen.dart';
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
      return Container(
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
                    name: 'USD: \$${cartPro.totalPrice()}',
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
                          .btcPrinceLive(dollor: cartPro.totalPrice()),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> exchangeRate) {
                        return ForText(
                          name: exchangeRate.hasError
                              ? '-- ERROR --'
                              : exchangeRate.hasData
                                  ? 'Btc: ${exchangeRate.data ?? 0}'
                                  : 'fetching ...',
                          bold: true,
                          size: 16,
                        );
                      }),
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
                                const LocationScreen(
                                    text: 'order'),
                          ),
                        );
                      })),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    });
  }
}
