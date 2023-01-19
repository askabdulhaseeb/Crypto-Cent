import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../enum/message_tabbar_enum.dart';
import '../../providers/chat/chat_page_provider.dart';
import '../empty_screen/empty_auth_screen.dart';
import 'group/group_chat_dashboard.dart';
import 'private/personal_chat_dashboard.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatPageProvider page = Provider.of<ChatPageProvider>(context);
    return AuthMethods.uid.isEmpty
        ? const EmptyAuthScreen(text: 'Please Log in to chat with others',)
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Messenger',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                _TabBar(page: page),
                Expanded(
                  child: (page.currentTab == MessageTabBarEnum.chat)
                      ? const PersonalChatDashboard()
                      : const GroupChatDashboard(),
                ),
              ],
            ),
          );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required ChatPageProvider page, Key? key})
      : _page = page,
        super(key: key);

  final ChatPageProvider _page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TabBarIconButton(
            icon: Icons.perm_contact_cal,
            title: 'Chats',
            isSelected: _page.currentTab == MessageTabBarEnum.chat,
            onTab: () {
              _page.updateTab(MessageTabBarEnum.chat);
            },
          ),
          const SizedBox(width: 50),
          TabBarIconButton(
            icon: Icons.groups_rounded,
            title: 'Groups',
            isSelected: _page.currentTab == MessageTabBarEnum.group,
            onTab: () {
              _page.updateTab(MessageTabBarEnum.group);
            },
          ),
        ],
      ),
    );
  }
}

class TabBarIconButton extends StatelessWidget {
  const TabBarIconButton({
    required this.onTab,
    required this.icon,
    required this.title,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);
  final bool isSelected;
  final IconData icon;
  final String title;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    final Color? color = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).iconTheme.color;
    return GestureDetector(
      onTap: onTab,
      child: Column(
        children: <Widget>[
          Icon(icon, color: color),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
