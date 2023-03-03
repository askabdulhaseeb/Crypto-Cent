// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/location.dart';
import '../../../providers/add_product_p.dart';
import '../../../providers/location_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../utilities/responsive.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../main_screen/main_screen.dart';
import '../../order/payment.dart';
import '../add_new_address.dart';
import 'mobile_location_screen.dart';
import 'web_location_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({required this.text, super.key});
  final String text;
  static const String routeName = '/locationScreen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int isSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(desktop: WebLocationScreen(text: widget.text), 
    mobile: MobileLocationScreen(text: widget.text), 
    tablet: WebLocationScreen(text: widget.text), 
    
    );
  }
}
