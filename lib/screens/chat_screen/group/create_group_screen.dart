import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../../../widgets/custom_widgets/show_loading.dart';
import '../../../database/app_user/auth_method.dart';
import '../../../database/chat_api.dart';
import '../../../enum/group_member_role_enum.dart';
import '../../../enum/login_method.dart';
import '../../../enum/message_type_enum.dart';
import '../../../function/attachment_picker.dart';
import '../../../function/time_date_function.dart';
import '../../../function/unique_id_functions.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/app_user/numbers_detail.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/chat_group_info.dart';
import '../../../models/chat/chat_group_member.dart';
import '../../../models/chat/message.dart';
import '../../../models/chat/message_attachment.dart';
import '../../../models/chat/message_read_info.dart';
import '../../../providers/provider.dart';
import '../../../widgets/custom_file_image_box.dart';
import '../../../widgets/custom_widgets/custom_validator.dart';

class CreateChatGroupScreen extends StatefulWidget {
  const CreateChatGroupScreen({Key? key}) : super(key: key);
  static const String routeName = '/create-chat-group-screen';

  @override
  State<CreateChatGroupScreen> createState() => _CreateChatGroupScreenState();
}

class _CreateChatGroupScreenState extends State<CreateChatGroupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  File? file;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Create Group',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                file != null
                    ? FutureBuilder<Uint8List?>(
                        future: file?.readAsBytes(),
                        builder: (BuildContext context,
                                AsyncSnapshot<Uint8List?> snapshot) =>
                            snapshot.hasData
                                ? CustomFileImageBox(
                                    file: snapshot.data,
                                    onTap: () async {
                                      await HapticFeedback.heavyImpact();
                                      onImagePick();
                                    },
                                  )
                                : CustomFileImageBox(
                                    file: null,
                                    onTap: () async {
                                      await HapticFeedback.heavyImpact();
                                      onImagePick();
                                    },
                                  ),
                      )
                    : CustomFileImageBox(
                        file: null,
                        onTap: () async {
                          await HapticFeedback.heavyImpact();
                          onImagePick();
                        },
                      ),
                CustomTextFormField(
                  controller: _name,
                  hint: 'Name',
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(height: 6),
                CustomTextFormField(
                  controller: _description,
                  readOnly: _isLoading,
                  hint: 'Add group description',
                  maxLines: 4,
                  maxLength: 160,
                  validator: (String? value) => null,
                ),
                const SizedBox(height: 10),
                _isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Create Group',
                        onTap: () async {
                          await HapticFeedback.heavyImpact();
                          onCreateGroup();
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onImagePick() async {
    final File? temp = await AttachmentPicker().gallery();
    if (temp == null) return;
    file = temp;
  }

  onCreateGroup() async {
    if (_key.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String groupID = UniqueIdFunctions.chatGroupID();
      final int time = TimeStamp.timestamp;
      final String me = AuthMethods.uid;
      final UserProvider userPro =
          Provider.of<UserProvider>(context, listen: false);
      final AppUser sender = userPro.user(me);
      String url = '';
      if (file != null) {
        url = await ChatAPI()
                .uploadGroupImage(file: file!, attachmentID: groupID) ??
            '';
      }
      final ChatGroupInfo info = ChatGroupInfo(
        groupID: groupID,
        name: _name.text.trim(),
        description: _description.text.trim(),
        imageURL: url,
        createdBy: me,
        createdDate: time,
        members: <ChatGroupMember>[
          ChatGroupMember(
            uid: me,
            role: GroupMemberRoleEnum.admin,
            addedBy: me,
            invitationAccepted: true,
            memberSince: time,
          ),
        ],
      );
      // await ChatAPI().sendMessage(
      //   sender: sender,
      //   receiver: AppUser(
      //     uid: 'null',
      //     loginMethod: LoginMethod.email,
      //     phoneNumber: NumberDetails(
      //       completeNumber: '',
      //       countryCode: '',
      //       isoCode: '',
      //       number: '',
      //       timestamp: time,
      //     ),
      //   ),
      //   chat: Chat(
      //     chatID: groupID,
      //     persons: <String>[AuthMethods.uid],
      //     groupInfo: info,
      //     isGroup: true,
      //     timestamp: time,
      //     lastMessage: Message(
      //       messageID: time.toString(),
      //       text: 'New Group Created',
      //       type: MessageTypeEnum.announcement,
      //       attachment: <MessageAttachment>[],
      //       sendBy: me,
      //       sendTo: <MessageReadInfo>[],
      //       timestamp: time,
      //     ),
      //   ),
      // );
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }
}
