import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../database/app_user/auth_method.dart';
import '../../../function/time_date_function.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../providers/user_provider.dart';
import '../../custom_widgets/custom_profile_image.dart';

class ChatDashboardTile extends StatelessWidget {
  const ChatDashboardTile({required this.chat, Key? key}) : super(key: key);
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider userPro, _) {
      final AppUser user = userPro.user(chat.persons
          .where((String element) => element != AuthMethods.uid)
          .first);
      return ListTile(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute<PersonalChatScreen>(
          //     builder: (_) => PersonalChatScreen(chatWith: user, chat: chat),
          //   ),
          // );
        },
        dense: true,
        leading: CustomProfileImage(imageURL: user.imageURL ?? ''),
        title: Text(
          user.name ?? 'issue',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          chat.lastMessage?.text ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          TimeStamp.timeInDigits(chat.timestamp),
          style: const TextStyle(fontSize: 12),
        ),
      );
    });
  }
}
