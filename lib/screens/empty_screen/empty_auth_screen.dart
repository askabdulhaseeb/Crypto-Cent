import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/app_images.dart';
import '../../utilities/responsive.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../auth/welcome_screen/welcome_screen.dart';
import 'empty_mobile_screen.dart';
import 'empty_web_screen.dart';

class EmptyAuthScreen extends StatelessWidget {
  const EmptyAuthScreen({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    
    return ResponsiveApp(
      desktop: EmptyWebAuthScreen(text: text), 
    mobile: EmptyMobileAuthScreen(text: text), 
    tablet:  EmptyWebAuthScreen(text: text),   
    );
  }
}
