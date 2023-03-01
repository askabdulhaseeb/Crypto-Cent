import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../database/chat_api.dart';
import '../../../models/chat/chat.dart';
import '../../../models/payment/orderd_product.dart';
import '../../../models/product/product_model.dart';
import '../../../providers/provider.dart';
import '../../../screens/product_screens/product_deatil/mobile_product_detail_screen.dart';
import '../../../screens/product_screens/product_deatil/product_detail_screen.dart';
import '../../custom_widgets/custom_network_image.dart';
import '../../custom_widgets/show_loading.dart';
import 'chat_prod_buy_view.dart';
import 'chat_prod_seller_view.dart';

class ChatProductTile extends StatelessWidget {
  const ChatProductTile({required this.chat, Key? key}) : super(key: key);
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<ProductProvider>(context, listen: false)
        .product(chat.pid ?? 'null');
    const double imageSize = 80;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 244, 244),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          StreamBuilder<Chat>(
              stream: ChatAPI().chat(chat.chatID),
              builder: (BuildContext context, AsyncSnapshot<Chat> snapshot) {
                if (snapshot.hasData) {
                  final Chat liveChat = snapshot.data!;
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            await HapticFeedback.heavyImpact();
                            showProdDetail(context, product);
                          },
                          child: Text(
                            product.productname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        product.uid == AuthMethods.uid
                            ? ChatProdSellerView(chat: liveChat)
                            : ChatProdBuyView(product: product, chat: liveChat),
                      ],
                    ),
                  );
                } else {
                  return snapshot.hasError
                      ? product.uid == AuthMethods.uid
                          ? const Text('NO OFFER PLACED YET!')
                          : Expanded(
                              child: ChatProdBuyView(
                                  product: product,
                                  chat: chat
                                    ..offer = OrderdProduct(
                                      pid: product.pid,
                                      sellerID: product.uid,
                                      localAmount: product.amount,
                                      exchangeRate: 1000,
                                      quantity: 1,
                                    )),
                            )
                      : const ShowLoading();
                }
              }),
          const SizedBox(width: 10),
          if (product.prodURL.isNotEmpty)
            InkWell(
              onTap: () async {
                await HapticFeedback.heavyImpact();
                showProdDetail(context, product);
              },
              child: SizedBox(
                height: imageSize * 1.3,
                width: imageSize * 1.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image(image: NetworkImage(product.prodURL[0].url),fit: BoxFit.fill,),
                 // child: CustomNetworkImage(imageURL: product.prodURL[0].url),
                ),
              ),
            ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  showProdDetail(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute<ProductDetailScreen>(
      builder: (BuildContext context) => ProductDetailScreen(product: product),
    ));
  }
}
