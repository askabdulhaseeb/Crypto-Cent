import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../function/web_appbar.dart';
import '../../../providers/app_provider.dart';
import '../../../utilities/app_images.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../../widgets/custom_widgets/footer_widget.dart';
import '../../../widgets/custom_widgets/password_textformfield.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../main_screen/main_screen.dart';
import '../signup_screen/signup_mobview.dart';
import '../signup_screen/signup_screen.dart';

class SignInWebview extends StatefulWidget {
  const SignInWebview({super.key});

  @override
  State<SignInWebview> createState() => _SignInWebviewState();
}

class _SignInWebviewState extends State<SignInWebview> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  WebAppBar().webAppBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
                child: Row(
                  children: <Widget>[
                   Expanded(child: SizedBox(
                    height: double.infinity,

                    child: Image.asset(AppImages.loginWebUi,fit: BoxFit.cover,))),
                   //Expanded(child: Container(color: Colors.red,)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                    const TextSpan(text: '''Not a member? '''),
                                    TextSpan(
                                      text: '''Join Us''',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.of(context)
                                            .pushNamed(SignupScreen.routeName),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              CustomTextFormField(
                                controller: _email,
                                hint: 'Email',
                                validator: (String? value) =>
                                    CustomValidator.email(value),
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
                                          final User? user = await AuthMethods()
                                              .loginWithEmailAndPassword(
                                            _email.text,
                                            _password.text,
                                          );
                                          // await NotificationsServices().onLogin(context);
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          if (!mounted) return;
                                          if (user != null) {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .onTabTapped(0);
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                              MainScreen.routeName,
                                              (Route<dynamic> route) => false,
                                            );
                                          }
                                        }
                                      },
                                    ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
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
