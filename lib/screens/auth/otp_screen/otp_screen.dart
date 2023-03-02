import 'package:flutter/material.dart';

import '../../../utilities/responsive.dart';
import 'mobile_otp_screen.dart';
import 'web_otp_screen.dart';
class OTPScreen  extends StatelessWidget {
  static const String routeName = '/otp-screen';
const OTPScreen ({super.key});
@override
 Widget build(BuildContext context) {
return const ResponsiveApp(
  desktop: WebOTPScreen(), 
  mobile:MobileOTPScreen() , 
  tablet: WebOTPScreen(), 
  
  );
}
}