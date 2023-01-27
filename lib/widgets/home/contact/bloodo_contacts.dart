import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../database/app_user/auth_method.dart';

import '../../../function/unique_id_functions.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';

import '../../../screens/chat_screen/private/personal_chat_screen.dart';
import '../../../screens/profile_screen/wallet/send_bitcoin.dart';
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
          children: <Widget>[
            CustomElevatedButton(
              bgColor: Theme.of(context).secondaryHeaderColor,
              title: '  Send  ',
              textStyle: const TextStyle(color: Colors.black54, fontSize: 16),
              onTap: () async {
                await HapticFeedback.heavyImpact();
                Navigator.of(context).push(
                  MaterialPageRoute<SendBitcoinScreen>(
                      builder: (BuildContext context) => SendBitcoinScreen(
                            iscontact: true,
                            sellerUser: user,
                          )),
                );
              },
              padding: const EdgeInsets.symmetric(horizontal: 6),
            ),
            const SizedBox(
              width: 10,
            ),
            CustomElevatedButton(
              title: 'Message',
              onTap: () async {
                await HapticFeedback.heavyImpact();
                Navigator.of(context).push(
                  MaterialPageRoute<PersonalChatScreen>(
                    builder: (BuildContext context) => PersonalChatScreen(
                      chat: Chat(
                        chatID: UniqueIdFunctions.personalChatID(
                            chatWith: user.uid),
                        persons: <String>[AuthMethods.uid, user.uid],
                      ),
                      chatWith: user,
                    ),
                  ),
                );
              },
              border: Border.all(color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 6),
            )
          ],
        ),
      ),
    );
  }
}
