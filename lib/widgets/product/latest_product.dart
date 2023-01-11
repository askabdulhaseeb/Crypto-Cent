import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../widgets/product/product_tile.dart';

class LatestProductsList extends StatelessWidget {
  const LatestProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productPro = Provider.of<ProductProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width * 0.68,
      width: double.infinity,
      child: ListView.builder(
        itemCount: productPro.products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ProductTile(
            product: productPro.products[index],
          );
        },
      ),
    );
  }
}
