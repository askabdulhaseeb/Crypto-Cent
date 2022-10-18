import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class FillCartScreen extends StatelessWidget {
  const FillCartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart '),
      ),
      body: ListView.builder(
        itemCount: cartPro.cartItem.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
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
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    cartPro
                                        .addProduct(cartPro.cartItem[index].id);
                                  },
                                  icon: const Icon(Icons.add_circle_outline,
                                      size: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 220,
                                  child: Text(
                                    'Review',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 36,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                        (cartPro.cartItem[index].quantity)
                                            .toString()),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
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
                                const Spacer(),
                                IconButton(
                                  onPressed:
                                      cartPro.cartItem[index].quantity < 2
                                          ? null
                                          : () {
                                              cartPro.removeProduct(
                                                  cartPro.cartItem[index].id);
                                            },
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        height: 102,
                        width: MediaQuery.of(context).size.width * 0.25,
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
                const SizedBox(width: 300, child: Divider()),
              ],
            ),
          );
        },
      ),
    );
  }
}
