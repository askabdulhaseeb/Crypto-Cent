// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

import '../../../function/web_appbar.dart';
import '../../../providers/auth_provider.dart';
import '../../../utilities/app_images.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/footer_widget.dart';
import '../../../widgets/custom_widgets/phone_number_field.dart';
import '../otp_screen/otp_screen.dart';

class WebPhoneNumberScreen extends StatefulWidget {
  const WebPhoneNumberScreen({Key? key}) : super(key: key);
  @override
  State<WebPhoneNumberScreen> createState() => _WebPhoneNumberScreenState();
}

class _WebPhoneNumberScreenState extends State<WebPhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebAppBar().webAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
                child: Row(
                  children: [
                    Expanded(child: SizedBox(
                    height: double.infinity,

                    child: Image.asset(AppImages.loginWebUi,fit: BoxFit.cover,))),
                    Expanded(
                      child: Consumer<AuthProvider>(
                          builder: (BuildContext context, AuthProvider authPro, _) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'Enter your phone number',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Boloodo will send an SMS message to varify your phone number, Select your Country and enter your phone number',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              PhoneNumberField(
                                initialCountryCode: authPro.phoneNumber?.countryCode ?? 'GB',
                                bgColor: Colors.transparent,
                                onChange: (PhoneNumber? value) =>
                                    authPro.onPhoneNumberChange(value),
                              ),
                             
                              SizedBox(
                                width: 240,
                                child: CustomElevatedButton(
                                  borderRadius: BorderRadius.circular(12),
                                  title: 'Send'.toUpperCase(),
                                  onTap: () async{
                                       await HapticFeedback.heavyImpact();
                                    authPro.verifyPhone(context);
                                    // Navigator.push(
                                    //   context,
                                    //   // ignore: always_specify_types
                                    //   MaterialPageRoute(
                                    //     builder: (BuildContext context) => const OTPScreen(),
                                    //   ),
                                    // );
                                  Navigator.of(context).pushNamed(OTPScreen.routeName);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
                const FooterWidget(),
        ],
      ),
    );
  }
}
