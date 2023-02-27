import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../providers/app_provider.dart';
import '../../../utilities/app_images.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../../widgets/custom_widgets/password_textformfield.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../main_screen/main_screen.dart';
import '../signup_screen/signup_screen.dart';

class SigninMobview extends StatefulWidget {
  const SigninMobview({Key? key}) : super(key: key);

  @override
  State<SigninMobview> createState() => _SigninMobviewState();
}

class _SigninMobviewState extends State<SigninMobview> {
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
                'Enter your email and password to signin',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 64),
              CustomTextFormField(
                controller: _email,
                hint: 'Email',
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
                        await HapticFeedback.heavyImpact();
                        if (_key.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          final User? user =
                              await AuthMethods().loginWithEmailAndPassword(
                            _email.text,
                            _password.text,
                          );
                         // await NotificationsServices().onLogin(context);
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
                            .pushNamed(SignupScreen.routeName),
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
