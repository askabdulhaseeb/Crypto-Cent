import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              const Text(
                'Your Customer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
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
              Expanded(
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
                          // shrinkWrap: true,
                          // primary: false,
                          controller: scrollController,
                          itemCount: widget.customers.length,
                          itemBuilder: (BuildContext context, int index) {
                            final AppUser user =
                                userPro.user(widget.customers[index]);
                            final String cUserUID = widget.customers[index];
                            final bool isSelected =
                                selectedUser.contains(cUserUID);
                            final bool alreadyMember =
                                widget.chat.persons.contains(cUserUID);
                            return InkWell(
                              onTap: () async{
                                await HapticFeedback.heavyImpact();
                                if (alreadyMember) return;
                                if (selectedUser.contains(cUserUID)) {
                                  selectedUser.remove(cUserUID);
                                } else {
                                  selectedUser.add(cUserUID);
                                }
                                setState(() {});
                              },
                              child: _MemberTile(
                                user: user,
                                alreadyMember: alreadyMember,
                                isSelected: isSelected,
                              ),
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

class _MemberTile extends StatelessWidget {
  const _MemberTile({
    Key? key,
    required this.user,
    required this.alreadyMember,
    required this.isSelected,
  }) : super(key: key);

  final AppUser user;
  final bool alreadyMember;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          CustomProfileImage(imageURL: user.imageURL ?? ''),
          const SizedBox(width: 10),
          Expanded(
            child: Text(user.name ?? '', maxLines: 1),
          ),
          if (!alreadyMember)
            Icon(
              isSelected ? Icons.circle : Icons.circle_outlined,
              color: Theme.of(context).primaryColor,
            ),
        ],
      ),
    );
  }
}
