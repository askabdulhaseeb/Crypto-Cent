import 'package:flutter/material.dart';

import '../../custom_widgets/custom_widget.dart';
import '../../custom_widgets/password_textformfield.dart';

class ChnagePassword extends StatelessWidget {
  ChnagePassword({super.key});
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarWidget(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordTextFormField(
              controller: _currentPassword,
              starticon: Icons.lock,
              color: const Color(0xffF6F7F9),
              hint: 'Current Password',
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordTextFormField(
              controller: _newPassword,
              starticon: Icons.lock,
              color: const Color(0xffF6F7F9),
              
              hint: 'New Password',
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordTextFormField(
              controller: _confirmPassword,
              starticon: Icons.lock,
              color: const Color(0xffF6F7F9),
              hint: 'Confirm Password',
            ),
            const Spacer(),
            CustomElevatedButton(title: 'Update Password', onTap: () {}),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbarWidget(BuildContext context) {
    return AppBar(
      title: const ForText(
        name: 'Change Password',
        bold: true,
      ),
      actions: [
        Column(
          children: const [
            SizedBox(
              height: 15,
            ),
            Icon(Icons.more_vert),
          ],
        ),
        const SizedBox(
          width: 20,
        )
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
    );
  }
}
