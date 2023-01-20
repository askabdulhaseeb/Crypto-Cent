import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../enum/group_member_role_enum.dart';
import '../../../enum/login_method.dart';
import '../../../function/report_bottom_sheets.dart';
import '../../../function/time_date_function.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/app_user/numbers_detail.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/chat_group_info.dart';
import '../../../models/chat/chat_group_member.dart';
import '../../../models/chat/message.dart';
import '../../../providers/provider.dart';
import '../../../widgets/chat/add_group_member_widget.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/text_field_like_bg.dart';

class GroupChatDetailScreen extends StatelessWidget {
  const GroupChatDetailScreen({required this.chat, Key? key}) : super(key: key);
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final ChatGroupInfo info = chat.groupInfo!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Group Info',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            CustomProfileImage(imageURL: info.imageURL, radius: 80),
            const SizedBox(height: 8),
            Text(
              info.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 3),
            Text(
              info.members.length <= 1
                  ? 'Group - ${info.members.length} member'
                  : 'Group - ${info.members.length} members',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextFieldLikeBG(child: Text(info.description, maxLines: 5)),
            TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return AddGroupMemberWidget(chat: chat);
                  },
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Member'),
            ),
            Expanded(
              child: TextFieldLikeBG(
                padding: const EdgeInsets.all(0),
                child: Consumer<UserProvider>(
                    builder: (BuildContext context, UserProvider userPro, _) {
                  return ListView.builder(
                      itemCount: info.members.length,
                      itemBuilder: (BuildContext context, int index) {
                        final AppUser user =
                            userPro.user(info.members[index].uid);
                        return ListTile(
                          leading:
                              CustomProfileImage(imageURL: user.imageURL ?? ''),
                          title: Text(user.name ?? ''),
                          subtitle: Text(
                            info.members[index].role.json,
                          ),
                        );
                      });
                }),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
