import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/custom_widgets/custom_elevated_button.dart';
import '../widgets/custom_widgets/custom_textformfield.dart';



class SupportPage extends StatelessWidget {
 SupportPage({Key? key}) : super(key: key);
  static const String routePath = '/support';
  final TextEditingController _name=TextEditingController();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _subject=TextEditingController();
  final TextEditingController _message=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      'Boloodo Support Center',
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  CustomTextFormField(hint: 'Enter your name', controller: _name,),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                 CustomTextFormField(hint: 'Enter your email',controller: _email,),
                  const Text(
                    'Subject',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  CustomTextFormField(hint: 'Enter your subject',controller: _subject,),
                  const Text(
                    'Message',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                CustomTextFormField(
                      hint: 'Enter your message', maxLines: 5,controller: _message),
                  SizedBox(
                    width: 100,
                    child: CustomElevatedButton(
                      title: 'Send',
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
