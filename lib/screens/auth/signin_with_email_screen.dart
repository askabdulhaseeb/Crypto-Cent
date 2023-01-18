import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../providers/app_provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/custom_widgets/password_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../main_screen/main_screen.dart';
import 'signup_with_email.dart';

class SigninWithEmailScreen extends StatefulWidget {
  const SigninWithEmailScreen({Key? key}) : super(key: key);
  static const String routeName = '/signin-with-email';

  @override
  State<SigninWithEmailScreen> createState() => _SigninWithEmailScreenState();
}

class _SigninWithEmailScreenState extends State<SigninWithEmailScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SizedBox(
          width: 80,
          child: Image.asset(AppImages.logo),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              const Text(
                'Sign In here!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Text(
                'Enter your Boloodo email and password to signin',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 64),
              CustomTextFormField(
                controller: _email,
                hint: 'boloodo@host.com',
                validator: (String? value) => CustomValidator.email(value),
                keyboardType: TextInputType.emailAddress,
                autoFocus: true,
                readOnly: _isLoading,
              ),
              PasswordTextFormField(controller: _password),
              const SizedBox(height: 10),
              _isLoading
                  ? const ShowLoading()
                  : CustomElevatedButton(
                      title: 'Sign In',
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          final User? user =
                              await AuthMethods().loginWithEmailAndPassword(
                            _email.text,
                            _password.text,
                          );
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
              const Spacer(),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey),
                  children: <TextSpan>[
                    const TextSpan(text: '''Don't have any account? '''),
                    TextSpan(
                      text: '''Sign Up''',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context)
                            .pushNamed(SignupWithEmailScreen.routeName),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
