import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/notification_services.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../main_screen/main_screen.dart';
import 'registration_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);
  static const String routeName = '/otp-screen';

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otp = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Varification'), centerTitle: true),
      body: Consumer<AuthProvider>(
          builder: (BuildContext context, AuthProvider authPro, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              if (authPro.phoneNumber != null)
                Text(
                  'Code is send to ${authPro.phoneNumber!.completeNumber}',
                  style: const TextStyle(color: Colors.grey),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Edit Number'),
              ),
              CustomTextFormField(
                controller: _otp,
                maxLength: 6,
                onChanged: (String? value) async {
                  if (value!.length == 6) {
                    setState(() {
                      isLoading = true;
                    });
                    final int num = await authPro.varifyOTP(value);
                    if (!mounted) return;
                    if (num == 0) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    } else if (num == 1) {
                     // await NotificationsServices().onLogin(context);
                      setState(() {
                        isLoading = false;
                      });
                      if (!mounted) return;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MainScreen.routeName,
                          (Route<dynamic> route) => false);
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                textAlign: TextAlign.center,
                showSuffixIcon: false,
                style: const TextStyle(letterSpacing: 20),
              ),
              isLoading
                  ? const ShowLoading()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('''Didn't received the OTP?'''),
                        TextButton(
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async => authPro.verifyPhone(context),
                        ),
                      ],
                    ),
            ],
          ),
        );
      }),
    );
  }
}
