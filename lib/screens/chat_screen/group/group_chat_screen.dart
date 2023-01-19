import 'package:flutter/material.dart';

import '../../../database/chat_api.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/message.dart';
import '../../../widgets/chat/chat_text_field.dart';
import '../../../widgets/chat/message_list.dart';
import '../../../widgets/chat/message_tile.dart';
import '../../../widgets/chat/no_old_chat_available_widget.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import 'group_chat_detail_screen.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({required this.chat, Key? key}) : super(key: key);
  final Chat chat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<GroupChatDetailScreen>(
              builder: (BuildContext context) =>
                  GroupChatDetailScreen(chat: chat),
            ));
          },
          child: Row(
            children: <Widget>[
              CustomProfileImage(imageURL: chat.groupInfo?.imageURL ?? ''),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(chat.groupInfo?.name ?? 'null'),
                    const Text(
                      'Tap here for more group info',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
    );
  }
}
