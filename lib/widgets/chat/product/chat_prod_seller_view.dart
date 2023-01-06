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
                Text('\$${chat.offer?.localAmount ?? 0}'),
              ],
            ),
            const Text('  X  '),
            Column(
              children: <Widget>[
                const Text('QTY'),
                Text('\$${chat.offer?.quantity ?? 0}'),
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
                  name:
                      '\$${(chat.offer?.localAmount ?? 0) * (chat.offer?.quantity ?? 0)}',
                  bold: true,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        FutureBuilder<double>(
          future: CryptoFunction().btcPrinceLive(
              dollor:
                  (chat.offer?.localAmount ?? 0) * (chat.offer?.quantity ?? 0)),
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
        Row(
          children: <Widget>[
            Expanded(
              child: CustomElevatedButton(
                title: 'Confirm',
                padding: const EdgeInsets.all(5),
                onTap: () {
                  // TODO: Accept offer

                  // when user accept the offer it remove update the value amount from
                  // buys wallets (means pending payment)

                  // if Buy didn't have that much payment their sould be an error message
                  // send where message type will be MessageTypeEnum.prodOfferRejected

                  // and if the available balance is more then that amount
                  // success message will send where message type will be MessageTypeEnum.prodOfferAccepted
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomElevatedButton(
                title: 'Decline',
                padding: const EdgeInsets.all(5),
                bgColor: Colors.red[200],
                onTap: () {
                  // TODO: Decline offer
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
