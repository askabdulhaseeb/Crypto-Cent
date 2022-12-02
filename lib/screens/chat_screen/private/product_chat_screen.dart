import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../database/chat_api.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../database/app_user/auth_method.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/message.dart';
import '../../../providers/provider.dart';
import '../../../widgets/chat/chat_text_field.dart';
import '../../../widgets/chat/message_tile.dart';
import '../../../widgets/chat/product/chat_product_tile.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class ProductChatScreen extends StatelessWidget {
  const ProductChatScreen({required this.chat, Key? key}) : super(key: key);
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
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
                        ? Column(
                            children: <Widget>[
                              ChatProductTile(chat: chat),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: const <Widget>[
                                    Text(
                                      'Say Hi!',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'and start conversation',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              ChatProductTile(chat: chat),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: messages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return MessageTile(
                                        message: messages[index]);
                                  },
                                ),
                              ),
                            ],
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Consumer<UserProvider>(builder: (
        BuildContext context,
        UserProvider userPro,
        _,
      ) {
        final AppUser chatWith = userPro.user(chat.persons
            .where((String element) => element != AuthMethods.uid)
            .first);
        return GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute<OthersProfile>(
            //     builder: (_) => OthersProfile(user: chatWith),
            //   ),
            // );
          },
          child: Row(
            children: <Widget>[
              CustomProfileImage(imageURL: chatWith.imageURL ?? '', radius: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      chatWith.name ?? 'issue',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Tap here to open profile',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
