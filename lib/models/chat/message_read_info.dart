import '../../function/time_date_function.dart';

class MessageReadInfo {
  MessageReadInfo({
    required this.uid,
    this.delivered = true,
    this.seen = true,
    this.deliveryAt,
    this.seenAt,
  });

  final String uid;
  final bool delivered;
  final bool seen;
  final int? deliveryAt;
  final int? seenAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'delivered': delivered,
      'seen': seen,
      'seen_at': seenAt ?? TimeStamp.timestamp,
      'delivery_at': deliveryAt ?? TimeStamp.timestamp,
    };
  }

  // ignore: sort_constructors_first
  factory MessageReadInfo.fromMap(Map<String, dynamic> map) {
    return MessageReadInfo(
      uid: map['uid'] ?? '',
      delivered: map['delivered'] ?? true,
      seen: map['seen'] ?? true,
      deliveryAt: map['delivery_at'],
      seenAt: map['seen_at'],
    );
  }
}
