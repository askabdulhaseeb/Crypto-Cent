import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../function/crypto_function.dart';
import '../../../models/cart.dart';
import '../../../providers/cart_provider.dart';
import '../../../utilities/responsive.dart';
import '../../custom_widgets/custom_network_image.dart';
import '../../custom_widgets/cutom_text.dart';
import 'mobile_cart_tile.dart';
import 'web_cart_tile.dart';

class CartItem extends StatelessWidget {
  const CartItem({required this.item, Key? key}) : super(key: key);

  final Cart item;

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      desktop: WebCartItem(item: item),
     mobile: MobileCartItem(item:item),
      tablet:  WebCartItem(item: item),
      );
  }
}
