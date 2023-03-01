import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../providers/rating_provider.dart';
import '../product_tile/product_tile.dart';

class WebLatestProduct extends StatelessWidget {
  WebLatestProduct({
    super.key,
    required this.height,
  });
int height;
  @override
  Widget build(BuildContext context) {
      ProductProvider productPro = Provider.of<ProductProvider>(context);
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: ListView.builder(
        itemCount: productPro.products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ProductTile(
            product: productPro.products[index],
            reviews:  Provider.of<RatingProvider>(context).productReviews(productPro.products[index].pid),
          );
        },
      ),
    );
  }
}