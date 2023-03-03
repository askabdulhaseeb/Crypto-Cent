import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../providers/rating_provider.dart';
import '../../widgets/product/product_tile/product_tile.dart';

class WebLatestProduct extends StatelessWidget {
  WebLatestProduct({
    super.key, 
  });
  @override
  Widget build(BuildContext context) {
      ProductProvider productPro = Provider.of<ProductProvider>(context);
    return GridView.count( shrinkWrap: true,
    primary: false,
    childAspectRatio: 90 / 110,
    mainAxisSpacing: 8,
    crossAxisCount: 3,
    children:List.generate(productPro.products.length, (int index) {
     return ProductTile(
          product: productPro.products[index],
          reviews:  Provider.of<RatingProvider>(context).productReviews(productPro.products[index].pid),
        );
    })
    );
  }
}