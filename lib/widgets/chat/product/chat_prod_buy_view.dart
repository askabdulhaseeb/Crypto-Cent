import 'package:flutter/material.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../database/chat_api.dart';
import '../../../enum/message_type_enum.dart';
import '../../../function/crypto_function.dart';
import '../../../function/time_date_function.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/message.dart';
import '../../../models/chat/message_attachment.dart';
import '../../../models/chat/message_read_info.dart';
import '../../../models/product/product_model.dart';
import '../../custom_widgets/custom_textformfield.dart';
import '../../custom_widgets/show_loading.dart';

class ChatProdBuyView extends StatefulWidget {
  const ChatProdBuyView({
    required this.product,
    required this.chat,
    Key? key,
  }) : super(key: key);

  final Product product;
  final Chat chat;

  @override
  State<ChatProdBuyView> createState() => ChatProdBuyViewState();
}

class ChatProdBuyViewState extends State<ChatProdBuyView> {
  String newOffer = '1';
  String _qty = '1';
  late TextEditingController _controller;
  @override
  void initState() {
    newOffer = widget.chat.offer!.localAmount.toString();
    _qty = widget.chat.offer!.quantity.toString();
    _controller = TextEditingController(text: newOffer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap:
                  // _qty == widget.product.quantity
                  //     ? null
                  //     :
                  () {
                int temp = int.parse(_qty);
                temp++;
                setState(() {
                  _qty = temp.toString();
                });
              },
              child: const Icon(Icons.add_circle_outline, size: 20),
            ),
            Container(
              height: 36,
              width: 30,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(_qty)),
            ),
            GestureDetector(
              onTap: int.parse(_qty) < 2
                  ? null
                  : () {
                      int temp = int.parse(_qty);
                      temp--;
                      setState(() {
                        _qty = temp.toString();
                      });
                    },
              child: const Icon(Icons.remove_circle_outline, size: 20),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Unit Prince'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomTextFormField(
                      controller: _controller,
                      onChanged: (String p0) => setState(() {
                        newOffer = p0;
                      }),
                      showSuffixIcon: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                    ),
                  ),
                  newOffer == widget.chat.offer!.localAmount.toString() &&
                          _qty == widget.chat.offer!.quantity.toString()
                      ? const SizedBox()
                      : TextButton(
                          onPressed: () async {
                            widget.chat.offer!.localAmount =
                                double.parse(newOffer);
                            widget.chat.offer!.quantity = int.parse(_qty);
                            final int time = TimeStamp.timestamp;
                            Message newMsg = Message(
                              messageID: '$time',
                              text:
                                  'UNIT PRICE: ${widget.chat.offer!.localAmount} & QTY: ${widget.chat.offer!.quantity}',
                              type: MessageTypeEnum.prodOffer,
                              attachment: <MessageAttachment>[],
                              sendBy: AuthMethods.uid,
                              sendTo: <MessageReadInfo>[
                                MessageReadInfo(uid: widget.product.uid),
                              ],
                              timestamp: time,
                            );
                            widget.chat.offer = widget.chat.offer!;
                            widget.chat.lastMessage = newMsg;
                            await ChatAPI().updateOffer(widget.chat);
                          },
                          child: const Text(
                            'New Offer',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                ],
              ),
              FutureBuilder<double>(
                future: CryptoFunction().btcPrinceLive(
                    dollor: widget.chat.offer!.localAmount *
                        widget.chat.offer!.quantity),
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  return snapshot.hasData
                      ? Text(
                          'BTC: ${snapshot.data}',
                          style: const TextStyle(fontSize: 11),
                        )
                      : snapshot.hasError
                          ? const Text('-ERROR-')
                          : const ShowLoading();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
