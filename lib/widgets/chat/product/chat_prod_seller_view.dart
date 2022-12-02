import 'package:flutter/material.dart';

import '../../../function/crypto_function.dart';
import '../../../models/chat/chat.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/cutom_text.dart';

class ChatProdSellerView extends StatelessWidget {
  const ChatProdSellerView({required this.chat, Key? key}) : super(key: key);
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text('UNIT PRICE'),
                Text('\$${chat.offer!.localAmount}'),
              ],
            ),
            const Text('  X  '),
            Column(
              children: <Widget>[
                const Text('QTY'),
                Text('\$${chat.offer!.quantity}'),
              ],
            ),
            const Text('  =  '),
            Column(
              children: <Widget>[
                const ForText(
                  name: 'TOTAL',
                  bold: true,
                ),
                ForText(
                  name: '\$${chat.offer!.localAmount * chat.offer!.quantity}',
                  bold: true,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        FutureBuilder<double>(
          future: CryptoFunction().btcPrinceLive(
              dollor: chat.offer!.localAmount * chat.offer!.quantity),
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            return snapshot.hasData
                ? Text(
                    'BTC: ${snapshot.data}',
                    style: const TextStyle(fontSize: 11),
                  )
                : snapshot.hasError
                    ? const Text('BTC: -ERROR-')
                    : const Text('BTC: fetching...');
          },
        ),
        CustomElevatedButton(
          title: 'Accept Offer',
          padding: const EdgeInsets.all(5),
          onTap: () {},
        ),
      ],
    );
  }
}
