import 'package:flutter/material.dart';

import '../../../models/product/product_model.dart';
import '../../../models/review.dart';
import '../../../utilities/responsive.dart';
import 'mobile_product_tile.dart';
import 'web_product_tile.dart';
class ProductTile extends StatelessWidget {
const ProductTile({required this.product,this.reviews,super.key});
final Product product;
  final List<Review>? reviews;
@override
 Widget build(BuildContext context) {
return ResponsiveApp(desktop: WebProductTile(product:product,reviews:reviews),
 mobile: MobileProductTile(product:product ,reviews: reviews), 
 tablet: WebProductTile(product:product,reviews:reviews),
 );
}
}