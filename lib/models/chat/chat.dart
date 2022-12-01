import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../enum/message_type_enum.dart';
import '../payment/orderd_product.dart';
import 'chat_group_info.dart';
import 'message.dart';
import 'message_attachment.dart';

class Chat {
  Chat({
    required this.chatID,
    required this.persons,
    this.lastMessage,
    this.pid,
    this.offer,
    this.prodIsVideo = false,
    this.isGroup = false,
    this.groupInfo,
    this.timestamp = 0,
  });

  final String chatID;
  final List<String> persons;
  final bool isGroup;
  final ChatGroupInfo? groupInfo;
  final String? pid;
  final bool? prodIsVideo;
  OrderdProduct? offer;
  Message? lastMessage;
  List<Message>? unseenMessages;
  int timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chat_id': chatID,
      'persons': persons,
      'is_group': isGroup,
      'group_info': groupInfo?.toMap(),
      'last_message': lastMessage!.toMap(),
      'pid': pid,
      'offer': offer?.toMap(),
      'prod_is_video': prodIsVideo ?? false,
      'unseen_messages': unseenMessages?.map((Message x) => x.toMap()).toList(),
      'timestamp': timestamp,
    };
  }

  Map<String, dynamic> addMembers() {
    return <String, dynamic>{
      'persons': FieldValue.arrayUnion(persons),
      'group_info': groupInfo?.addMembers(),
      'last_message': lastMessage!.toMap(),
    };
  }

  Map<String, dynamic> sendMesssage() {
    return <String, dynamic>{
      'last_message': lastMessage!.toMap(),
      'unseen_messages': unseenMessages?.map((Message x) => x.toMap()).toList(),
      'timestamp': timestamp,
    };
  }

  Map<String, dynamic> updateMessage() {
    return <String, dynamic>{
      'last_message': lastMessage!.toMap(),
      'unseen_messages': unseenMessages?.map((Message x) => x.toMap()).toList(),
      'timestamp': timestamp,
    };
  }

  Map<String, dynamic> updateOffer() {
    return <String, dynamic>{
      'offer': offer!.toMap(),
      'last_message': lastMessage!.toMap(),
    };
  }

  // ignore: sort_constructors_first
  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatID: map['chat_id'] ?? '',
      persons: List<String>.from(map['persons']),
      isGroup: map['is_group'] ?? false,
      groupInfo: map['group_info'] != null
          ? ChatGroupInfo.fromMap(map['group_info'])
          : null,
      pid: map['pid'],
      offer: map['offer'] == null ? null : OrderdProduct.fromMap(map['offer']),
      prodIsVideo: map['prod_is_video'] ?? true,
      lastMessage: Message.fromMap(map['last_message']),
      timestamp: map['timestamp'] ?? 0,
    );
  }
}
