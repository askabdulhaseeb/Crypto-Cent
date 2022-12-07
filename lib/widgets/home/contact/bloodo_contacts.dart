import 'package:flutter/material.dart';

import '../../../models/app_user/app_user.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_network_image.dart';
import '../../custom_widgets/custom_profile_image.dart';
import '../../custom_widgets/cutom_text.dart';

class BloodoContacts extends StatelessWidget {
  BloodoContacts({super.key, required this.user});
  AppUser user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 200,
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
              title: 'Send',
              onTap: () {},
              padding: const EdgeInsets.symmetric(horizontal: 6),
            ),
            const SizedBox(
              width: 10,
            ),
            CustomElevatedButton(
              title: 'Message',
              onTap: () {},
              bgColor: Colors.transparent,
              textStyle: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18),
              border: Border.all(color: Theme.of(context).primaryColor),
              padding: EdgeInsets.symmetric(horizontal: 6),
            )
          ],
        ),
      ),
    );
  }
}
