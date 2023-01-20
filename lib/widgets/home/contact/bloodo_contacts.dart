import 'package:flutter/material.dart';

import '../../../models/app_user/app_user.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_profile_image.dart';

class BloodoContacts extends StatelessWidget {
  const BloodoContacts({required this.user, super.key});
  final AppUser user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        leading: SizedBox(
            height: 40,
            width: 40,
            child: CustomProfileImage(imageURL: user.imageURL, radius: 24)),
        title: Text(user.name ?? ''),
        // subtitle: Text(_subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton(
              bgColor: Theme.of(context).secondaryHeaderColor,
              title: '  Send  ',
              textStyle: const TextStyle(color: Colors.black54, fontSize: 16),
              onTap: () {},
              padding: const EdgeInsets.symmetric(horizontal: 6),
            ),
            const SizedBox(
              width: 10,
            ),
            CustomElevatedButton(
              title: 'Message',
              onTap: () {},
              border: Border.all(color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 6),
            )
          ],
        ),
      ),
    );
  }
}
