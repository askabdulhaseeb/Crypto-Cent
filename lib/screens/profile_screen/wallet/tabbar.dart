import 'package:flutter/material.dart';

import 'recieve_bitcoin.dart';
import 'send_bitcoin.dart';

class Tabbarview extends StatefulWidget {
  const Tabbarview({Key? key}) : super(key: key);

  @override
  State<Tabbarview> createState() => _TabbarviewState();
}

class _TabbarviewState extends State<Tabbarview> {
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
            'Bitcoin Transaction',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(tabs: <Widget>[
            Text(
              'Recieve',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Send',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        body: const TabBarView(
          children: <Widget>[
            RecieveBitcoinScreen(),
            SendBitcoinScreen(),
          ],
        ),
      ),
    );
  }
}
