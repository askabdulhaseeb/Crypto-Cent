import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/payment/order.dart';
import '../../../models/payment/orderd_product.dart';

class OrderHistoryTile extends StatelessWidget {
  const OrderHistoryTile({required this.item, super.key});
  final Order item;

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd-MM-yy');
    return ExpansionTile(
      title: Text('order no 1'),
      subtitle: Text('Trailing expansion arrow icon'),
      children: item.products
          .map(
            (OrderdProduct e) => ListTile(
              title: Text(e.pid),
            ),
          )
          .toList(),
    );
  }
}
