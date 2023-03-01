import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';
import '../product_tile/product_tile.dart';
import '../../../providers/rating_provider.dart';
import '../../../utilities/responsive.dart';
import 'mobile_latest_product.dart';
import 'web_latest_product.dart';

class LatestProductsList extends StatelessWidget {
  const LatestProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return ResponsiveApp(
  

      desktop: WebLatestProduct(height: 400),
      mobile:const MobileLatestProduct(),
      tablet: WebLatestProduct(height: 300),
    );
  }

 
}


