// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../function/rating_function.dart';
import '../../../models/product/product_model.dart';
import '../../../../providers/product_provider.dart';
import '../../../../utilities/app_images.dart';
import '../../../../widgets/custom_widgets/custom_network_image.dart';
import '../../../../widgets/custom_widgets/custom_widget.dart';
import '../../../models/review.dart';
import '../../../screens/product_screens/product_deatil/mobile_product_detail_screen.dart';
import '../../../screens/product_screens/product_deatil/product_detail_screen.dart';
import '../../custom_widgets/custom_rating_star.dart';

class WebProductTile extends StatelessWidget {
  const WebProductTile({required this.product, this.reviews, Key? key})
      : super(key: key);
  final Product product;
  final List<Review>? reviews;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
      ),
      child: AspectRatio(
        aspectRatio: 10 / 14,
        child: GestureDetector(
          onTap: (){
                     Navigator.push(
              context,
              MaterialPageRoute<ProductDetailScreen>(
                builder: (BuildContext context) =>
                    ProductDetailScreen(product: product),
              ));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                         child: Image(image: NetworkImage(product.prodURL[0].url),fit: BoxFit.fill,),
                     
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          product.productname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                     
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '\$${product.amount}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(onPressed: (){
                              //Todo: make this as pushedname
                           Navigator.push(
              context,
              MaterialPageRoute<ProductDetailScreen>(
                builder: (BuildContext context) =>
                    ProductDetailScreen(product: product),
              ));
                            }, icon: Icon(Icons.arrow_forward))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
