import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/payment/payment_provider.dart';
import '../../providers/provider.dart';
import '../../widgets/custom_widgets/bar_chart/custom_bar_chart.dart';
import '../../widgets/custom_widgets/bar_chart/history_card.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    PaymentProvider paymentPro = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My order History'),
        leading: IconButton(
            onPressed: (() {
              Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        // ignore: always_specify_types
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  newMethod(context, 'All', () {}),
                  newMethod(context, 'Running', () {}),
                  newMethod(context, 'Previous', () {}),
                ],
              ),
              const SizedBox(height: 20),
              const CustomBarChart(),
              const Expanded(child: HistroyCrad())
            ],
          ),
        ),
      ),
    );
  }

  Widget newMethod(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(46),
        ),
        child: Center(
          child: ForText(
            name: title,
            color: Colors.white,
            size: 20,
            bold: true,
          ),
        ),
      ),
    );
  }
}
