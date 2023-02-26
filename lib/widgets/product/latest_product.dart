import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../widgets/product/product_tile.dart';
import '../../providers/rating_provider.dart';
import '../../utilities/responsive.dart';

class LatestProductsList extends StatelessWidget {
  const LatestProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productPro = Provider.of<ProductProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return ResponsiveApp(
      mobile:  mobileUi(width * 0.68, productPro),
      tablet:  mobileUi(width * 0.4, productPro),
      desktop:  mobileUi(400, productPro),
    );
  }

  SizedBox mobileUi(double width, ProductProvider productPro) {
    return SizedBox(
      height: width ,
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
