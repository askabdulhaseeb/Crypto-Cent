import 'package:flutter/material.dart';

import '../../../models/chat/chat.dart';

class GroupChatDetailScreen extends StatelessWidget {
  const GroupChatDetailScreen({required this.chat, Key? key}) : super(key: key);
  final Chat chat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GroupChatDetailScreen'),
      ),
      body: Center(
        child: Text('GroupChatDetailScreen'),
      ),
    );
  }
}
