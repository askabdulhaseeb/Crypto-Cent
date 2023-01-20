import 'package:flutter/material.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/chat_api.dart';
import '../../enum/group_member_role_enum.dart';
import '../../enum/message_type_enum.dart';
import '../../function/time_date_function.dart';
import '../../models/chat/chat.dart';
import '../../models/chat/chat_group_member.dart';
import '../../models/chat/message.dart';
import '../../models/chat/message_attachment.dart';
import '../../models/chat/message_read_info.dart';
import '../../screens/main_screen/main_screen.dart';

class AddGroupMemberWidget extends StatefulWidget {
  const AddGroupMemberWidget({required this.chat, Key? key}) : super(key: key);
  final Chat chat;
  @override
  State<AddGroupMemberWidget> createState() => _AddGroupMemberWidgetState();
}

class _AddGroupMemberWidgetState extends State<AddGroupMemberWidget> {
  final List<String> selectedSupp = <String>[];
  List<String> addableSupp = <String>[];
  List<String> customers = <String>[];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          if (selectedSupp.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    final String me = AuthMethods.uid;
                    final int time = TimeStamp.timestamp;
                    for (String element in selectedSupp) {
                      widget.chat.persons.add(element);
                      widget.chat.groupInfo!.members.add(
                        ChatGroupMember(
                          uid: element,
                          role: GroupMemberRoleEnum.member,
                          addedBy: me,
                          invitationAccepted: false,
                          memberSince: time,
                        ),
                      );
                    }
                    widget.chat.lastMessage = Message(
                      messageID: TimeStamp.timestamp.toString(),
                      text: selectedSupp.length == 1
                          ? 'A new member added'
                          : '${selectedSupp.length} new members added',
                      type: MessageTypeEnum.announcement,
                      attachment: <MessageAttachment>[],
                      sendBy: me,
                      isPrivateMessage: false,
                      sendTo: widget.chat.persons
                          .map((String e) => MessageReadInfo(uid: e))
                          .toList(),
                      timestamp: time,
                    );
                    await ChatAPI().addMembers(widget.chat);
                    if (!mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        MainScreen.routeName, (Route<dynamic> route) => false);
                  },
                  icon: const Icon(Icons.add),
                  label: Text('Add ${selectedSupp.length} members'),
                )
              ],
            ),
          customers.isEmpty
              ? const Center(
                  child: Text('All Contacts are already in group'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: customers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return const Text('User Data here');
                  },
                ),
        ],
      ),
    );
  }
}
