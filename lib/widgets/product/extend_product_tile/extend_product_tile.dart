import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/product/product_model.dart';
import '../../../../providers/product_provider.dart';
import '../../../../utilities/app_images.dart';
import '../../../../widgets/custom_widgets/custom_network_image.dart';
import '../../../../widgets/custom_widgets/custom_widget.dart';
import '../../../screens/product_screens/product_deatil/mobile_product_detail_screen.dart';
import '../../../utilities/responsive.dart';
import '../web_extend_product_tile.dart';
import 'mobile_extend_product_tile.dart';
import 'web_extend_product_tile.dart';

class ExtendProductTile extends StatelessWidget {
  ExtendProductTile({required this.product,Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    //double widthe = MediaQuery.of(context).size.width;
    return ResponsiveApp(
      desktop: WebExtendProductTile(product: product),
       mobile: MobileExtendProductTile(product: product),
        tablet: MobileExtendProductTile(product: product),);
  }
}
