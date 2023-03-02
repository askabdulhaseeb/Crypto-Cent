import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../providers/cart_provider.dart';
import '../../utilities/responsive.dart';
import '../../widgets/cart/empty/empty_cart_widget.dart';
import '../../widgets/cart/fill/fill_cart_widget.dart';
import '../empty_screen/empty_auth_screen.dart';
import 'mobile_cart_screen.dart';
import 'web_cart_screen.dart';


class CartScreen extends StatelessWidget {
   static const String routeName = '/cart-screen';
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return const ResponsiveApp(
      desktop: WebCartScreen(), 
      mobile: MobileCartScreen(), 
      tablet: WebCartScreen(), 
      );
  }
}
