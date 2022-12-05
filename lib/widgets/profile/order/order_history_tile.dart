import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/payment/order.dart';
import '../../../models/payment/orderd_product.dart';
import '../../../providers/payment/payment_provider.dart';

class OrderHistoryTile extends StatelessWidget {
  const OrderHistoryTile({required this.item, super.key});
  final Order item;

  @override
  Widget build(BuildContext context) {
    PaymentProvider paymentPro = Provider.of<PaymentProvider>(context);
    DateFormat format = DateFormat('dd-MM-yy');
    return ExpansionTile(
      title: Text('Status ${item.status.value}'),
      subtitle:
          Text(item.orderID, maxLines: 1, overflow: TextOverflow.ellipsis),
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
