import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/payment/order.dart';
import '../../../providers/payment/payment_provider.dart';
import 'order_history_tile.dart';

class SellOrder extends StatelessWidget {
  const SellOrder({super.key});
  @override
  Widget build(BuildContext context) {
    PaymentProvider orderPro = Provider.of<PaymentProvider>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: orderPro.order.length,
        itemBuilder: (BuildContext context, int index) {
          final Order item = orderPro.order[index];
          return OrderHistoryTile(item: item);
        },
      ),
    );
  }
}
