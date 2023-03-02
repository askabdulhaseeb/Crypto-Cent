import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cart.dart';
import '../../../providers/cart_provider.dart';
import '../../../utilities/responsive.dart';
import '../cart_checkout_widget.dart';
import '../tile/cart_tile.dart';
import 'mobile_fill_cart_widget.dart';
import 'web_fill_cart_widget.dart';

class FillCartWidget extends StatelessWidget {
  const FillCartWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      desktop:WebFillCartWidget(),
     mobile: MobileFillCartWidget(),
      tablet: WebFillCartWidget(),
      );
  }
}
