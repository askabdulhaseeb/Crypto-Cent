import 'package:flutter/material.dart';

import '../custom_widgets/custom_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrdersScreen'),
      ),
      body: Column(
        children: [
          Text(
            'usman afzal',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          ForText(
            name: 'usman afzal',
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
