import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/chat_api.dart';
import '../../database/crypto_wallet/binance_api.dart';
import '../../enum/message_type_enum.dart';
import '../../function/crypto_function.dart';
import '../../function/unique_id_functions.dart';
import '../../models/app_user/app_user.dart';
import '../../models/chat/chat.dart';
import '../../models/chat/message.dart';
import '../../models/chat/message_attachment.dart';
import '../../models/chat/message_read_info.dart';
import '../../models/product/product_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../widgets/custom_widgets/custom_rating_star.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../providers/crypto_wallet/binance_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_widgets/custom_network_image.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/product/product_url_slider.dart';
import '../cart_screen/cart_screen.dart';
import '../chat_screen/private/product_chat_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.product, super.key});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider userPro, _) {
            final AppUser user = userPro.user(widget.product.uid);
            return Row(
              children: <Widget>[
                CustomProfileImage(imageURL: user.imageURL ?? '', radius: 24),
                const SizedBox(width: 10),
                Text(
                  user.name ?? 'null',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
        elevation: 0,
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: IconButton(
                onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute<ProductChatScreen>(
                      builder: (BuildContext context) => ProductChatScreen(
                        chat: Chat(
                          chatID:
                              UniqueIdFunctions.productID(widget.product.pid),
                          persons: <String>[
                            AuthMethods.uid,
                            widget.product.uid
                          ],
                          pid: widget.product.pid,
                        ),
                        chatWith:
                            Provider.of<UserProvider>(context, listen: false)
                                .user(widget.product.uid),
                        product: widget.product,
                      ),
                    )),
                icon: Icon(
                  Icons.chat,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          const SizedBox(width: 10),
        ],
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ProductURLsSlider(urls: widget.product.prodURL),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    Text(
                      widget.product.productname,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomRatingBar(
                              itemSize: 24,
                              initialRating: 5,
                              onRatingUpdate: (_) {},
                            ),
                            const ForText(
                              name: '(0 reviews)',
                              size: 13,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '\$ ${widget.product.amount}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            FutureBuilder<double>(
                                future: CryptoFunction().btcPrinceLive(
                                    dollor: widget.product.amount),
                                builder: (BuildContext context,
                                    AsyncSnapshot<double> exchangeRate) {
                                  return ForText(
                                    name: exchangeRate.hasError
                                        ? '-- ERROR --'
                                        : exchangeRate.hasData
                                            ? 'Btc: ${exchangeRate.data ?? 0}'
                                            : 'fetching ...',
                                    size: 11,
                                  );
                                }),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const ForText(
                      name: 'Description',
                      bold: true,
                      size: 22,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.description.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomElevatedButton(
                    title: 'Send Offer',
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    bgColor: Theme.of(context).secondaryHeaderColor,
                    onTap: () {
                      final TextEditingController _offer =
                          TextEditingController();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                Text(
                                    'Orignal Prince: ${widget.product.amount}'),
                                CustomTextFormField(
                                  controller: _offer,
                                  keyboardType: TextInputType.number,
                                  hint: 'Set your offer here',
                                  validator: (String? value) =>
                                      CustomValidator.isEmpty(value),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
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
                                            offer: _offer.text,
                                            user: Provider.of<UserProvider>(
                                                    context,
                                                    listen: false)
                                                .user(widget.product.uid),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                      title: 'Add to Cart',
                      onTap: () async {
                        await bottomSheet(context, cartPro);
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  sendOffer({required String offer, required AppUser user}) async {
    if (offer == '0') return;
    final int time = DateTime.now().microsecondsSinceEpoch;
    final String chatID = UniqueIdFunctions.productID(widget.product.pid);
    await ChatAPI().sendMessage(
      Chat(
        chatID: chatID,
        persons: <String>[AuthMethods.uid, user.uid],
        lastMessage: Message(
          messageID: time.toString(),
          text: '''Hello\nI'm interested.\nMy price is $offer''',
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
        prodIsVideo: false,
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<dynamic> bottomSheet(
      BuildContext context, CartProvider cartPro) async {
    return await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StatefulBuilder(builder: (
            BuildContext context,
            Function setState,
          ) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: CustomNetworkImage(
                            imageURL: widget.product.prodURL[0].url),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.product.productname.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$${widget.product.amount}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            ForText(
                              name:
                                  'Availavle Quantity: ${widget.product.quantity}',
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
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
                      icon: Icon(
                        Icons.remove_circle_outline,
                        size: 24,
                        color: quantity < 2 ? Colors.grey : Colors.red,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
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
                    ),
                    IconButton(
                      onPressed: quantity >= int.parse(widget.product.quantity)
                          ? null
                          : () {
                              setState(() {
                                quantity++;
                              });
                            },
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 24,
                        color: quantity >= int.parse(widget.product.quantity)
                            ? Colors.grey
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                (cartPro.checkExit(widget.product))
                    ? const Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 29,
                      )
                    : CustomElevatedButton(
                        title: 'Add to cart',
                        onTap: () {
                          cartPro.addtocart(widget.product, quantity);
                          Navigator.of(context).pop();
                        }),
                const SizedBox(height: 10),
              ],
            );
          }),
        );
      },
    );
  }
}
