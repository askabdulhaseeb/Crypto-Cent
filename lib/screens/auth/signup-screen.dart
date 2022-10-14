import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signupscreen';
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignupScreen'),
      ),
    );
  }
}
