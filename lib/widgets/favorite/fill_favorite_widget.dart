import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../product/product_tile/product_tile.dart';

class FillFavoriteWidget extends StatelessWidget {
  const FillFavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider prodPro, _) {
      final List<String> favList = prodPro.favorites;
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 500 ? 3 : 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 200 / 250),
        itemCount: favList.length,
        itemBuilder: (BuildContext context, int index) => ProductTile(
          product: prodPro.product(favList[index]),
        ),
      );
    });
  }
}
