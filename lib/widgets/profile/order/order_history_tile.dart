import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/payment/order.dart';

class OrderHistoryTile extends StatelessWidget {
  const OrderHistoryTile({required this.item, super.key});
  final Order item;

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd-MM-yy');
    return ListTile(
      leading: const Icon(Icons.attach_money_outlined),
      title: Text(
        item.customerUID,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Status: ${item.status}',
          ),
          // const SizedBox(height: 10),
          Text(
            'Date: ',
          ),
        ],
      ),
      trailing: Column(
        children: <Widget>[
          const Text('BTC'),
        ],
      ),
    );
  }
}
