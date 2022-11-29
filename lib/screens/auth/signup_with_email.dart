import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/custom_widgets/password_textformfield.dart';

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
              CustomElevatedButton(
                title: 'Sign up',
                onTap: () async {
                // TODO: SIGN UP WITH EMAIL

                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
