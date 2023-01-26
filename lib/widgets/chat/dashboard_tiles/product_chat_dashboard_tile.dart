import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../database/app_user/auth_method.dart';
import '../../../function/time_date_function.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../models/product/product_model.dart';
import '../../../providers/product_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../screens/chat_screen/private/product_chat_screen.dart';
import '../product_chat_photo.dart';

class ProductChatDashboardTile extends StatelessWidget {
  const ProductChatDashboardTile({required this.chat, Key? key})
      : super(key: key);
  final Chat chat;
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ProductProvider>(builder: (
      BuildContext context,
      UserProvider userPro,
      ProductProvider prodPro,
      _,
    ) {
      final Product product = prodPro.product(chat.pid!);
      final AppUser user = userPro.user(chat.persons[chat.persons
          .indexWhere((String element) => element != AuthMethods.uid)]);
      return ListTile(
        onTap: () async{
          await HapticFeedback.heavyImpact();
          Navigator.of(context).push(
            MaterialPageRoute<ProductChatScreen>(
              builder: (_) => ProductChatScreen(chat: chat),
            ),
          );
        },
        dense: true,
        leading: ProductChatPhoto(
          radius: 20,
          userImage: user.imageURL ?? '',
          productImage: product.prodURL[0].url,
        ),
        title: Text(
          user.name ?? 'issue',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          chat.lastMessage?.text ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          TimeStamp.timeInDigits(chat.timestamp),
          style: const TextStyle(fontSize: 12),
        ),
      );
    });
  }
}
