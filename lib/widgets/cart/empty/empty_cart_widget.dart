import 'package:flutter/material.dart';

import '../../../utilities/responsive.dart';
import 'mobile_empty_cart.dart';
import 'web_empty_cart.dart';
class EmptyCartWidget extends StatelessWidget {
const EmptyCartWidget({super.key});
@override
 Widget build(BuildContext context) {
return const ResponsiveApp(
  desktop:WebEmptyCartWidget(),
 mobile: MobileEmptyCartWidget(), 
 tablet: WebEmptyCartWidget(),
 
 );
}
}