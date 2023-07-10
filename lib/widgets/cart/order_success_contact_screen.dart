// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../function/unique_id_functions.dart';
import '../../models/app_user/app_user.dart';
import '../../models/chat/chat.dart';
import '../../providers/provider.dart';
import '../../screens/chat_screen/private/personal_chat_screen.dart';
import '../../screens/main_screen/main_screen.dart';
import '../custom_widgets/custom_profile_image.dart';
import '../custom_widgets/custom_widget.dart';

class OrderSuccessContactScreen extends StatelessWidget {
  const OrderSuccessContactScreen({super.key});
  @override
  Widget build(BuildContext context) {
    UserProvider userPro = Provider.of<UserProvider>(context);
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<MainScreen>(
              builder: (BuildContext context) => const MainScreen(),
            ),
            (Route route) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<MainScreen>(
                      builder: (BuildContext context) => const MainScreen(),
                    ),
                    (Route route) => false);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('your order is done'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ForText(
                  name: 'Congratulation',
                  size: 22,
                  bold: true,
                  color: Colors.green[700],
                ),
                const ForText(name: 'Your Order has been placed succefully.'),
                const SizedBox(height: 20),
                ForText(
                  name:
                      'For the payment and product check.\nContact with person Given bellow....',
                  textAlign: TextAlign.start,
                  color: Colors.blue[900],
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    AppUser user =
                        userPro.user(cartPro.receiptList[index].sellerId);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(children: <Widget>[
                        Expanded(
                            flex: 2,
                            //  child: SizedBox(),
                            child: CustomProfileImage(imageURL: user.imageURL)),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ForText(name: user.name ?? ''),
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: CustomElevatedButton(
                              title: 'Message',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<PersonalChatScreen>(
                                    builder: (BuildContext context) =>
                                        PersonalChatScreen(
                                      chat: Chat(
                                          chatID:
                                              UniqueIdFunctions.personalChatID(
                                                  chatWith: user.uid),
                                          persons: <String>[
                                            user.uid,
                                            AuthMethods.uid
                                          ]),
                                      chatWith: user,
                                    ),
                                  ),
                                );
                              },
                              bgColor: Colors.amber,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              margin: const EdgeInsets.all(0),
                            )),
                      ]),
                    );
                  },
                  itemCount: cartPro.receiptList.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
