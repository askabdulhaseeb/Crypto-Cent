import 'package:flutter/material.dart';

import '../../../database/chat_api.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/message.dart';
import '../../../widgets/chat/chat_text_field.dart';
import '../../../widgets/chat/message_list.dart';
import '../../../widgets/chat/message_tile.dart';
import '../../../widgets/chat/no_old_chat_available_widget.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class PersonalChatScreen extends StatelessWidget {
  const PersonalChatScreen({
    required this.chat,
    required this.chatWith,
    Key? key,
  }) : super(key: key);
  final Chat chat;
  final AppUser chatWith;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute<OthersProfile>(
              //     builder: (BuildContext context) =>
              //         OthersProfile(user: chatWith),
              //   ),
              // );
            },
            child: Row(
              children: <Widget>[
                CustomProfileImage(imageURL: chatWith.imageURL ?? ''),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(chatWith.name ?? 'no name'),
                      Text(
                        'Tab here to open profile',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
            child: StreamBuilder<List<Message>>(
                stream: ChatAPI().messages(chat.chatID),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Message>> snapshot) {
                  if (snapshot.hasData) {
                    List<Message> messages = snapshot.data ?? <Message>[];
                    return (messages.isEmpty)
                        ? const NoOldChatAvailableWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: messages.length,
                            reverse: true,
                            itemBuilder: (BuildContext context, int index) {
                              return MessageTile(message: messages[index]);
                            },
                          );
                  } else {
                    return snapshot.hasError
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: const <Widget>[
                              Icon(Icons.report, color: Colors.grey),
                              Text(
                                'Some issue found',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        : const ShowLoading();
                  }
                }),
          ),
            ChatTextField(chat: chat),
          ],
        ),
      ),
    );
  }
}
