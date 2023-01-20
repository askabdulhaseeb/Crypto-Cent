import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enum/group_member_role_enum.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/chat_group_info.dart';
import '../../../models/chat/chat_group_member.dart';
import '../../../providers/provider.dart';
import '../../../widgets/chat/add_group_member_widget.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/text_field_like_bg.dart';

class GroupChatDetailScreen extends StatelessWidget {
  const GroupChatDetailScreen({required this.chat, Key? key}) : super(key: key);
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final List<ChatGroupMember> members =
        chat.groupInfo?.members ?? <ChatGroupMember>[];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Group Info',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              CustomProfileImage(
                  imageURL: chat.groupInfo?.imageURL, radius: 80),
              const SizedBox(height: 8),
              Text(
                chat.groupInfo?.name ?? 'null',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 3),
              Text(
                members.length <= 1
                    ? 'Group - ${members.length} member'
                    : 'Group - ${members.length} members',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              TextFieldLikeBG(
                  child: Text(chat.groupInfo?.description ?? '', maxLines: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isDismissible: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        context: context,
                        builder: (BuildContext context) {
                          final List<String> customer =
                              Provider.of<PaymentProvider>(context,
                                      listen: false)
                                  .oldCustomer();
                          return AddGroupMemberWidget(
                              chat: chat, customers: customer);
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Member'),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: members.length,
                itemBuilder: (BuildContext context, int index) {
                  return _MemberTile(member: members[index]);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member, Key? key}) : super(key: key);
  final ChatGroupMember member;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider userPro, _) {
      final AppUser user = userPro.user(member.uid);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            CustomProfileImage(imageURL: user.imageURL ?? ''),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(user.name ?? ''),
                  Text(member.role.json),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
