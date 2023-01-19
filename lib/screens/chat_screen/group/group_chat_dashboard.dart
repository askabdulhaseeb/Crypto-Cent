import 'package:flutter/material.dart';

import '../../../database/chat_api.dart';
import '../../../models/chat/chat.dart';
import '../../../widgets/chat/dashboard_tiles/group_dashboard_tile.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import 'create_group_screen.dart';

class GroupChatDashboard extends StatelessWidget {
  const GroupChatDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Chat>>(
      stream: ChatAPI().groups(),
      builder: (_, AsyncSnapshot<List<Chat>> snapshot) {
        if (snapshot.hasError) {
          return const _ErrorWidget();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShowLoading();
          } else {
            if (snapshot.hasData) {
              List<Chat> chat = snapshot.data ?? <Chat>[];
              return Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(CreateChatGroupScreen.routeName),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Group'),
                  ),
                  chat.isEmpty
                      ? const Center(child: Text('No Group available yet'))
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: chat.length,
                          separatorBuilder: (_, __) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(height: 1),
                          ),
                          itemBuilder: (_, int index) {
                            return GroupChatDashboardTile(chat: chat[index]);
                          },
                        ),
                ],
              );
            } else {
              return const Text('Error Text');
            }
          }
        }
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Text(
            'Some thing goes wrong',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
