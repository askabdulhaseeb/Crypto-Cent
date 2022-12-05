import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recieve_order.dart';
import 'send_order.dart';

class OrderTabbar extends StatefulWidget {
  const OrderTabbar({Key? key}) : super(key: key);

  @override
  State<OrderTabbar> createState() => _OrderTabbarState();
}

class _OrderTabbarState extends State<OrderTabbar> {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Order complete Transaction',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          bottom: const TabBar(tabs: <Widget>[
            Text(
              'Recieve',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Send',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]),
        ),
        body: const TabBarView(
          children: <Widget>[
            RecieveOrder(),
            SendOrder(),
          ],
        ),
      ),
    );
  }
}
