import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../utilities/responsive.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/phone_number_field.dart';
import '../otp_screen/otp_screen.dart';
import 'mobile_phone_number_screen.dart';
import 'web_phone_number_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);
  static const String routeName = '/phone-number-screen';
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveApp(
      desktop: WebPhoneNumberScreen(),
      mobile: MobilePhoneNumberScreen (),
      tablet: WebPhoneNumberScreen(),
    );
  }
}
