import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/chat_api.dart';
import '../../enum/group_member_role_enum.dart';
import '../../enum/message_type_enum.dart';
import '../../function/time_date_function.dart';
import '../../models/app_user/app_user.dart';
import '../../models/chat/chat.dart';
import '../../models/chat/chat_group_member.dart';
import '../../models/chat/message.dart';
import '../../models/chat/message_attachment.dart';
import '../../models/chat/message_read_info.dart';
import '../../providers/provider.dart';
import '../../screens/main_screen/main_screen.dart';
import '../custom_widgets/custom_profile_image.dart';

class AddGroupMemberWidget extends StatefulWidget {
  const AddGroupMemberWidget({
    required this.chat,
    required this.customers,
    Key? key,
  }) : super(key: key);
  final Chat chat;
  final List<String> customers;
  @override
  State<AddGroupMemberWidget> createState() => _AddGroupMemberWidgetState();
}

class _AddGroupMemberWidgetState extends State<AddGroupMemberWidget> {
  final List<String> selectedUser = <String>[];
  List<String> addableSupp = <String>[];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (
        BuildContext context,
        ScrollController scrollController,
      ) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              if (selectedUser.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () async {
                        final String me = AuthMethods.uid;
                        final int time = TimeStamp.timestamp;
                        for (String element in selectedUser) {
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
                          text: selectedUser.length == 1
                              ? 'A new member added'
                              : '${selectedUser.length} new members added',
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
                            MainScreen.routeName,
                            (Route<dynamic> route) => false);
                      },
                      icon: const Icon(Icons.add),
                      label: Text('Add ${selectedUser.length} members'),
                    )
                  ],
                ),
              Flexible(
                child: widget.customers.isEmpty
                    ? const Center(
                        child: Text('All Contacts are already in group'),
                      )
                    : Consumer<UserProvider>(builder: (
                        BuildContext context,
                        UserProvider userPro,
                        _,
                      ) {
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          controller: scrollController,
                          itemCount: widget.customers.length,
                          itemBuilder: (BuildContext context, int index) {
                            final AppUser user =
                                userPro.user(widget.customers[index]);
                            final String cUserUID = widget.customers[index];
                            final bool isSelected =
                                selectedUser.contains(cUserUID);
                            return ListTile(
                              leading: CustomProfileImage(
                                  imageURL: user.imageURL ?? ''),
                              title: Text(user.name ?? ''),
                              trailing: Icon(
                                isSelected
                                    ? Icons.circle
                                    : Icons.circle_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: () {
                                if (selectedUser.contains(cUserUID)) {
                                  selectedUser.remove(cUserUID);
                                } else {
                                  selectedUser.add(cUserUID);
                                }
                                setState(() {});
                              },
                            );
                          },
                        );
                      }),
              ),
            ],
          ),
        );
      },
    );
  }
}
