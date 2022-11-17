import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../providers/cart_provider.dart';
import '../custom_widgets/custom_network_image.dart';
import '../custom_widgets/cutom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({required this.item, Key? key}) : super(key: key);

  final Cart item;

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
                        item.title,
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
                        'Btc  ${item.price * item.quantity}',
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
              Consumer<CartProvider>(
                  builder: (BuildContext context, CartProvider cartPro, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        cartPro.addProduct(item.id);
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
                        child: Text((item.quantity).toString()),
                      ),
                    ),
                    GestureDetector(
                      onTap: item.quantity < 2
                          ? null
                          : () {
                              cartPro.removeProduct(item.id);
                            },
                      child: const Icon(
                        Icons.remove,
                        size: 15,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: double.infinity,
                width: 120,
                child: CustomNetworkImage(
                  imageURL: item.imageurl,
                  fit: BoxFit.cover,
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
