import 'dart:convert';

WalletHistory walletHistoryFromMap(String str) =>
    WalletHistory.fromMap(json.decode(str));

String walletHistoryToMap(WalletHistory data) => json.encode(data.toMap());

class WalletHistory {
  WalletHistory({
    required this.wallet,
    required this.items,
    required this.pagination,
  });

  final String wallet;
  final List<WalletItem> items;
  final WalletPagination pagination;

  // ignore: sort_constructors_first
  factory WalletHistory.fromMap(Map<String, dynamic> json) => WalletHistory(
        wallet: json['wallet'],
        items: List<WalletItem>.from(json['items'].map((x) => WalletItem.fromMap(x))),
        pagination: WalletPagination.fromMap(json['pagination']),
      );

  Map<String, dynamic> toMap() => {
        'wallet': wallet,
        'items': List<dynamic>.from(items.map((x) => x.toMap())),
        'pagination': pagination.toMap(),
      };
}

class WalletItem {
  WalletItem({
    required this.id,
    required this.date,
    required this.type,
    required this.txs,
    required this.isConfirmed,
    required this.amount,
  });

  final String id;
  final DateTime date;
  final String type;
  final List<String> txs;
  final bool isConfirmed;
  final int amount;

  // ignore: sort_constructors_first
  factory WalletItem.fromMap(Map<String, dynamic> json) => WalletItem(
        id: json['id'],
        date: DateTime.parse(json['date']),
        type: json['type'],
        txs: List<String>.from(json['txs'].map((x) => x)),
        isConfirmed: json['is_confirmed'],
        amount: json['amount'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'type': type,
        'txs': List<dynamic>.from(txs.map((x) => x)),
        'is_confirmed': isConfirmed,
        'amount': amount,
      };
}

class WalletPagination {
  WalletPagination({
    required this.total,
    required this.offset,
    required this.limit,
  });

  final int total;
  final int offset;
  final int limit;

  // ignore: sort_constructors_first
  factory WalletPagination.fromMap(Map<String, dynamic> json) => WalletPagination(
        total: json['total'],
        offset: json['offset'],
        limit: json['limit'],
      );

  Map<String, dynamic> toMap() => {
        'total': total,
        'offset': offset,
        'limit': limit,
      };
}
