import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/chat_api.dart';
import '../../database/crypto_wallet/binance_api.dart';
import '../../enum/message_type_enum.dart';
import '../../function/unique_id_functions.dart';
import '../../models/app_user/app_user.dart';
import '../../models/chat/chat.dart';
import '../../models/chat/message.dart';
import '../../models/chat/message_attachment.dart';
import '../../models/chat/message_read_info.dart';
import '../../models/payment/orderd_product.dart';
import '../../models/product/product_model.dart';
import '../../providers/user_provider.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_textformfield.dart';
import '../custom_widgets/custom_validator.dart';

class SendOfferWidget extends StatefulWidget {
  const SendOfferWidget({required this.product, super.key});
  final Product product;

  @override
  State<SendOfferWidget> createState() => _SendOfferWidgetState();
}

class _SendOfferWidgetState extends State<SendOfferWidget> {
  final TextEditingController offer = TextEditingController();
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Center(
            child: Text(
              'Send Your Offer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('Orignal Prince: ${widget.product.amount}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: quantity < 2
                    ? null
                    : () {
                        setState(() {
                          quantity--;
                        });
                      },
                splashRadius: 16,
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 24,
                  color: quantity < 2 ? Colors.grey : Colors.red,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                onPressed: quantity >= int.parse(widget.product.quantity)
                    ? null
                    : () {
                        setState(() {
                          quantity++;
                        });
                      },
                splashRadius: 16,
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 24,
                  color: quantity >= int.parse(widget.product.quantity)
                      ? Colors.grey
                      : Colors.green,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: offer,
                  keyboardType: TextInputType.number,
                  hint: 'Set your offer here',
                  validator: (String? value) => CustomValidator.isEmpty(value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomElevatedButton(
                  title: 'Send',
                  onTap: () async {
                    sendOffer(
                      offer: offer.text,
                      quantity: quantity,
                      user: Provider.of<UserProvider>(context, listen: false)
                          .user(widget.product.uid),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  sendOffer({
    required String offer,
    required AppUser user,
    required int quantity,
  }) async {
    if (offer == '0') return;
    final int time = DateTime.now().microsecondsSinceEpoch;
    final String chatID = UniqueIdFunctions.productID(widget.product.pid);
    OrderdProduct order = OrderdProduct(
      pid: widget.product.pid,
      sellerID: widget.product.uid,
      localAmount: double.parse(offer),
      exchangeRate: await BinanceApi().btcPrice(),
      quantity: quantity,
    );
    await ChatAPI().sendMessage(
      Chat(
        chatID: chatID,
        persons: <String>[AuthMethods.uid, user.uid],
        lastMessage: Message(
          messageID: time.toString(),
          text: 'UNIT PRICE: $offer & QTY: 1',
          timestamp: time,
          sendBy: AuthMethods.uid,
          type: MessageTypeEnum.prodOffer,
          attachment: <MessageAttachment>[],
          sendTo: <MessageReadInfo>[
            MessageReadInfo(uid: user.uid),
          ],
        ),
        timestamp: time,
        pid: widget.product.pid,
        offer: order,
        prodIsVideo: false,
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
