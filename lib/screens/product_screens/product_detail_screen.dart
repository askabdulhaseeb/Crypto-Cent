import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../widgets/custom_widgets/custom_rating_star.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../providers/crypto_wallet/binance_provider.dart';
import '../../widgets/custom_widgets/custom_network_image.dart';
import '../cart_screen/cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.product, super.key});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    BinanceProvider binancePro = Provider.of<BinanceProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: IconButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute<CartScreen>(
                      builder: (BuildContext context) => const CartScreen(),
                    )),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          const SizedBox(width: 10),
        ],
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 250,
                width: 250,
                child: CustomNetworkImage(
                    imageURL: widget.product.imageurl, fit: BoxFit.fill),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    Text(
                      widget.product.productname.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomRatingBar(
                              itemSize: 24,
                              initialRating: 5,
                              onRatingUpdate: (_) {},
                            ),
                            const ForText(
                              name: '(0 reviews)',
                              size: 13,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '\$ ${widget.product.amount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const ForText(
                      name: 'About',
                      bold: true,
                      size: 22,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.description.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomElevatedButton(
                title: 'Add to Cart',
                onTap: () {
                  bottomSheet(context, cartPro, binancePro.coin.price);
                }),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Future<dynamic> bottomSheet(
      BuildContext context, CartProvider cartPro, double exchangerate) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatefulBuilder(builder: (
              BuildContext context,
              Function setState,
            ) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image(
                          image: NetworkImage(widget.product.imageurl),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 250,
                            child: Text(
                              widget.product.productname.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${widget.product.amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const ForText(name: 'Quantity', bold: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: quantity < 2
                            ? null
                            : () {
                                setState(() {
                                  quantity--;
                                });
                              },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          size: 15,
                        ),
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline, size: 15),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  (cartPro.checkExit(widget.product))
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 29,
                        )
                      : CustomElevatedButton(
                          title: 'Add to cart',
                          onTap: () {
                            cartPro.addtocart(
                                widget.product, quantity, exchangerate);
                            Navigator.of(context).pop();
                          }),
                  const SizedBox(height: 20),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
