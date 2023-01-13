import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../product/product_tile.dart';

class FillFavoriteWidget extends StatelessWidget {
  const FillFavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider prodPro, _) {
      final List<String> favList = prodPro.favorites;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.count(
          childAspectRatio: 200 / 330,
          mainAxisSpacing: 8,
          crossAxisSpacing: 4,
          crossAxisCount: 2,
          children: List<Widget>.generate(favList.length, (int index) {
            return ProductTile(
              product: prodPro.product(favList[index]),
            );
          }),
        ),
        // child: GridView.count(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: MediaQuery.of(context).size.width > 500 ? 3 : 2,
        //     crossAxisSpacing: 4,
        //     mainAxisSpacing: 4,
        //   ),
        //     childAspectRatio: 200 / 330,
        //   itemCount: favList.length,
        //   itemBuilder: (BuildContext context, int index) => ProductTile(
        //     product: prodPro.product(favList[index]),
        //   ),
        // ),
      );
    });
  }
}
