import 'package:flutter/material.dart';
import '../../../../../database/chat_api.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/message.dart';
import '../../../models/product/product_model.dart';
import '../../../widgets/chat/chat_text_field.dart';
import '../../../widgets/chat/message_tile.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../../widgets/product/product_url_slider.dart';
import '../../product_screens/product_detail_screen.dart';

class ProductChatScreen extends StatelessWidget {
  const ProductChatScreen({
    required this.chat,
    required this.chatWith,
    required this.product,
    Key? key,
  }) : super(key: key);
  final Chat chat;
  final AppUser chatWith;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, chatWith: chatWith),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 8),
          _ProductTile(product: product, user: chatWith),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<List<Message>>(
                stream: ChatAPI().messages(chat.chatID),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Message>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const ShowLoading();
                    default:
                      if (snapshot.hasData) {
                        List<Message> messages = snapshot.data ?? <Message>[];
                        return (messages.isEmpty)
                            ? SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text(
                                      'Say Hi!',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'and start conversation',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: messages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return MessageTile(message: messages[index]);
                                },
                              );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const <Widget>[
                            Icon(Icons.report, color: Colors.grey),
                            Text(
                              'Some issue found',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      }
                  }
                }),
          ),
          ChatTextField(chat: chat),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context, {required AppUser chatWith}) {
    return AppBar(
      titleSpacing: 0,
      title: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute<OthersProfile>(
          //     builder: (_) => OthersProfile(user: chatWith),
          //   ),
          // );
        },
        child: Row(
          children: <Widget>[
            CustomProfileImage(imageURL: chatWith.imageURL ?? ''),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    chatWith.name ?? 'issue',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Tap here to open profile',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product, required this.user, Key? key})
      : super(key: key);
  final Product product;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 80;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<ProductDetailScreen>(
          builder: (BuildContext context) =>
              ProductDetailScreen(product: product),
        ));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.productname,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SizedBox(height: 4),
                  Text(
                    'Price \$${product.amount.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available: ${product.quantity.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: imageSize,
              width: imageSize,
              child: ProductURLsSlider(
                urls: product.prodURL,
                width: imageSize,
                height: imageSize,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
