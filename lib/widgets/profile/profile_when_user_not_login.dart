import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_widget.dart';

class ProfilewhenUserNotLogin extends StatelessWidget {
  const ProfilewhenUserNotLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const ForText(
                name: 'Please Login to view Your Profile',
                bold: true,
                size: 18,
              ),
              CustomElevatedButton(title: 'title', onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
