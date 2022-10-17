import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';

class ProductFullScreen extends StatelessWidget {
  final Product product;
  const ProductFullScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image(
                    image: NetworkImage(product.imageurl),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  product.productname.toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w900,
                      fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Review ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$ ${product.amount}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const ForText(
                  name: 'About',
                  bold: true,
                  size: 22,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  product.description.toString(),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                Expanded(child: Container()),
                CustomElevatedButton(
                    title: 'Add to Cart',
                    onTap: () {
                      showModalBottomSheet(
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
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.cancel,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: Image(
                                          image: NetworkImage(product.imageurl),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 250,
                                            child: Text(
                                              product.productname.toString(),
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
                                            '\$${product.amount}',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      ForText(
                                        name: 'Quantity',
                                        bold: true,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: cartPro.quantity < 2
                                            ? null
                                            : () {
                                                cartPro.removeProduct(product);
                                              },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          size: 15,
                                        ),
                                      ),
                                      Text(
                                        cartPro.quantity.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print('add press');
                                          cartPro.addProduct(product);
                                        },
                                        icon: const Icon(
                                            Icons.add_circle_outline,
                                            size: 15),
                                      ),
                                      // Spacer(),
                                      // IconButton(
                                      //   onPressed: () {
                                      //     cartproviderScreen
                                      //         .deleteItem(cartattribute.id);
                                      //   },
                                      //   icon: Icon(Icons.delete_outline,
                                      //       size: 22),
                                      // ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  CustomElevatedButton(
                                      title: 'Add to cart', onTap: () {}),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
