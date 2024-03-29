import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../models/app_user/app_user.dart';
import '../../providers/provider.dart';
import '../custom_widgets/cutom_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, UserProvider userPro, _) {
        final AppUser user = userPro.user(AuthMethods.uid);
        final String imageURL = user.imageURL ?? '';
        final String name = user.name ?? '';
        return Container(
          height: 200,
          width: double.infinity,
          color: Theme.of(context).secondaryHeaderColor,
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
              const SizedBox(height: 10),
              ForText(
                name: name,
                size: 20,
                bold: true,
                color: Colors.black,
              )
            ],
          ),
        );
      },
    );
  }
}
