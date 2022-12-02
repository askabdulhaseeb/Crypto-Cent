import 'package:flutter/material.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../database/chat_api.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../models/product/product_model.dart';
import '../../../screens/product_screens/product_detail_screen.dart';
import '../../custom_widgets/custom_network_image.dart';
import '../../custom_widgets/show_loading.dart';
import 'chat_prod_buy_view.dart';
import 'chat_prod_seller_view.dart';

class ChatProductTile extends StatelessWidget {
  const ChatProductTile({
    required this.product,
    required this.user,
    required this.chat,
    Key? key,
  }) : super(key: key);
  final Product product;
  final AppUser user;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 80;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          StreamBuilder<Chat>(
              stream: ChatAPI().chat(chat.chatID),
              builder: (BuildContext context, AsyncSnapshot<Chat> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () => showProdDetail(context),
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
                            ? ChatProdSellerView(chat: chat)
                            : ChatProdBuyView(product: product, chat: chat),
                      ],
                    ),
                  );
                } else {
                  return snapshot.hasError
                      ? const Text('- ERROR -')
                      : const ShowLoading();
                }
              }),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => showProdDetail(context),
            child: SizedBox(
              height: imageSize,
              width: imageSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomNetworkImage(imageURL: product.prodURL[0].url),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  showProdDetail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<ProductDetailScreen>(
      builder: (BuildContext context) => ProductDetailScreen(product: product),
    ));
  }
}
