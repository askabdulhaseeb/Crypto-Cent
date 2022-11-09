import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/crypto_wallet/wallet_histroty.dart';

class WalletHistoryTile extends StatelessWidget {
  const WalletHistoryTile({required this.item, super.key});
  final WalletItem item;

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd-MM-yy');
    final bool received = item.type == 'receipt';
    return ListTile(
      leading: const Icon(Icons.attach_money_outlined),
      title: Text(
        item.id,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Status: ${item.isConfirmed}',
          ),
          // const SizedBox(height: 10),
          Text(
            'Date: ${format.format(item.date)}',
            style: TextStyle(
              color: received ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
      trailing: Column(
        children: <Widget>[
          const Text('BTC'),
          Text(
            '${item.amount / 100000000}',
            style: TextStyle(
              color: received ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
