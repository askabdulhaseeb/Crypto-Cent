import 'package:flutter/material.dart';

class BitcoinHistroyScreen extends StatelessWidget {
  const BitcoinHistroyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        leading: IconButton(
            onPressed: (() {
              //Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        // ignore: always_specify_types
        actions: const [Icon(Icons.more_vert)],
      ),
      body: Center(child: Text('No histrory Yet')),
    );
  }
}
