// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/chat_api.dart';
import '../../enum/message_type_enum.dart';
import '../../function/attachment_picker.dart';
import '../../function/time_date_function.dart';
import '../../models/chat/chat.dart';
import '../../models/chat/message.dart';
import '../../models/chat/message_attachment.dart';
import '../../models/chat/message_read_info.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({required this.chat, Key? key}) : super(key: key);
  final Chat chat;
  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _text = TextEditingController();
  List<File> files = <File>[];
  static const double borderRadius = 12;
  bool isLoading = false;
  MessageTypeEnum types = MessageTypeEnum.text;

  void _onListen() => setState(() {});

  @override
  void initState() {
    _text.addListener(_onListen);
    super.initState();
  }

  @override
  void dispose() {
    _text.dispose();
    _text.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (files.isNotEmpty)
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: files.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.file(files[index], fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 80,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        files.clear();
                      });
                    },
                    splashRadius: 16,
                    icon: const Icon(Icons.cancel),
                  ),
                )
              ],
            ),
          ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  builder: (BuildContext context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.camera_alt_outlined),
                        title: const Text('Camera'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          types = MessageTypeEnum.image;
                          final List<File> file =
                              await AttachmentPicker().cameraNotNULL();
                          if (file.isEmpty) return;
                          setState(() {
                            files = file;
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library_outlined),
                        title: const Text('Photos'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          types = MessageTypeEnum.image;
                          final List<File> file =
                              await AttachmentPicker().multiPicNotNULL();
                          if (file.isEmpty) return;
                          setState(() {
                            files = file;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
              splashRadius: 16,
              icon: const Icon(Icons.add),
            ),
            Flexible(
              child: TextFormField(
                controller: _text,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Write a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
            _text.text.isNotEmpty
                ? IconButton(
                    onPressed: () async {
                      if ((_text.text.trim().isEmpty && files.isEmpty) ||
                          isLoading) {
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      final int time = TimeStamp.timestamp;
                      List<MessageAttachment> attachments =
                          <MessageAttachment>[];
                      if (files.isNotEmpty) {
                        for (File element in files) {
                          final String? url = await ChatAPI().uploadAttachment(
                            file: element,
                            attachmentID:
                                '${time.toString()}-${TimeStamp.timestamp}',
                          );
                          if (url != null) {
                            attachments.add(MessageAttachment(
                              url: url,
                              type: types,
                            ));
                          }
                        }
                      }
                      setState(() {
                        files = <File>[];
                        isLoading = false;
                      });

                      final Message msg = Message(
                        messageID: time.toString(),
                        text: _text.text.trim(),
                        type: _text.text.isNotEmpty
                            ? MessageTypeEnum.text
                            : attachments[0].type,
                        attachment: attachments,
                        sendBy: AuthMethods.uid,
                        sendTo: <MessageReadInfo>[],
                        timestamp: time,
                      );
                      widget.chat.timestamp = time;
                      widget.chat.lastMessage = msg;
                      _text.clear();
                      await ChatAPI().sendMessage(widget.chat);
                    },
                    splashRadius: 16,
                    icon: Icon(
                      Icons.send,
                      color: isLoading
                          ? Colors.grey
                          : Theme.of(context).iconTheme.color,
                    ),
                  )
                : IconButton(
                    onPressed: () {},
                    splashRadius: 1,
                    icon: const Icon(Icons.send, color: Colors.grey),
                  ),
          ],
        ),
      ],
    );
  }
}