import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../models/app_user/app_user.dart';
import '../../providers/app_provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/custom_widgets/password_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../main_screen/main_screen.dart';

class SignupWithEmailScreen extends StatefulWidget {
  const SignupWithEmailScreen({Key? key}) : super(key: key);
  static const String routeName = '/signup-wuth-email';

  @override
  State<SignupWithEmailScreen> createState() => _SignupWithEmailScreenState();
}

class _SignupWithEmailScreenState extends State<SignupWithEmailScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confPassword = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final PhoneNumber _phoneNumber =
      PhoneNumber(countryISOCode: 'GB', countryCode: '', number: '');
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 80,
          child: Image.asset(AppImages.logo),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                const Text(
                  'Sign Up here!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Text(
                  'Enter your Infomation to create Boloodo account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 64),
                CustomTextFormField(
                  controller: _name,
                  hint: 'Name',
                  validator: (String? value) => CustomValidator.isEmpty(value),
                  autoFocus: true,
                  maxLength: 80,
                  readOnly: _isLoading,
                ),
                CustomTextFormField(
                  controller: _email,
                  hint: 'boloodo@host.com',
                  validator: (String? value) => CustomValidator.email(value),
                  keyboardType: TextInputType.emailAddress,
                  autoFocus: true,
                  readOnly: _isLoading,
                ),
                PasswordTextFormField(controller: _password),
                PasswordTextFormField(
                  controller: _confPassword,
                  hint: 'Confirm Password',
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Sign up',
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            if (_password.text != _confPassword.text) return;
                            setState(() {
                              _isLoading = true;
                            });
                            final User? user = await AuthMethods()
                                .signupWithEmailAndPassword(
                                    email: _email.text,
                                    name: _name.text,
                                    password: _password.text);
                            setState(() {
                              _isLoading = false;
                            });
                            if (!mounted) return;
                            if (user != null) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .onTabTapped(0);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                MainScreen.routeName,
                                (Route<dynamic> route) => false,
                              );
                            }
                          }
                        },
                      ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
