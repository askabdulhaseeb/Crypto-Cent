import 'package:flutter/material.dart';

import '../../../models/product/product_model.dart';
import '../../../utilities/responsive.dart';
import 'mobile_product_detail_screen.dart';
import 'web_product_detail_screen.dart';
class ProductDetailScreen extends StatelessWidget {
const ProductDetailScreen({required this.product,super.key});
final Product product;
@override
 Widget build(BuildContext context) {
return ResponsiveApp(desktop: WebProductDetailScreen(product: product),
 mobile: MobileProductDetailScreen(product: product), 
tablet: WebProductDetailScreen(product: product),);
}
}