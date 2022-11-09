import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../custom_widgets/cutom_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authPro, _) {
        final String imageURL = authPro.apUser.imageURL ?? '';
        final String name = authPro.apUser.name ?? '';
        return Container(
          height: 200,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 64,
                backgroundImage:
                    imageURL.isEmpty ? null : NetworkImage(imageURL),
                child: imageURL.isEmpty
                    ? const Icon(Icons.person, size: 80, color: Colors.grey)
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              ForText(
                name: name,
                size: 20,
                bold: true,
                color: Colors.white,
              )
            ],
          ),
        );
      },
    );
  }
}
