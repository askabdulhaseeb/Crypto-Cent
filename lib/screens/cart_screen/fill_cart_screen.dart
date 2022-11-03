import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../payment.dart';

class FillCartScreen extends StatelessWidget {
  const FillCartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cartPro.cartItem.length,
            itemBuilder: (BuildContext context, int index) {
              return CartItem(
                cartPro: cartPro,
                index: index,
              );
            },
          ),
        ),
        checkoutSection(context, cartPro, context),
      ],
    );
  }

  Widget checkoutSection(
      BuildContext ctx, CartProvider cartPro, BuildContext context) {
    //int  cartproviderScreen;
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
            children: [
              const Divider(),
              Row(
                children: <Widget>[
                  const ForText(
                    name: 'Select Item',
                  ),
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
                  ForText(
                    name: 'Discount',
                  ),
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
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    required this.cartPro,
    required this.index,
    Key? key,
  }) : super(key: key);

  final CartProvider cartPro;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 220,
                      child: Text(
                        cartPro.cartItem[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 6),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        const ForText(
                          name: '(0 reviews)',
                          size: 11,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 220,
                      child: Text(
                        '\$ ${cartPro.cartItem[index].price * cartPro.cartItem[index].quantity}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      cartPro.addProduct(cartPro.cartItem[index].id);
                    },
                    child: const Icon(Icons.add, size: 15),
                  ),
                  Container(
                    height: 36,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child:
                          Text((cartPro.cartItem[index].quantity).toString()),
                    ),
                  ),
                  GestureDetector(
                    onTap: cartPro.cartItem[index].quantity < 2
                        ? null
                        : () {
                            cartPro.removeProduct(cartPro.cartItem[index].id);
                          },
                    child: const Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                ],
              ),
              Container(
                height: double.infinity,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image(
                  image: NetworkImage(cartPro.cartItem[index].imageurl),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 240, child: Divider(color: Colors.grey[300])),
      ],
    );
  }
}
