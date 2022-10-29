import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../empty_screen/empty_screen.dart';
import 'wallet/wallet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthProvider authPro = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            uperscreen(context, authPro.apUser.name!, authPro.apUser.imageURL!),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                middelItems(
                    context, 'My Order\nHistory', AppImages.orderhistory),
                middelItems(
                    context, 'Delivery\nAddress', AppImages.deliveryaddress)
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  bottomnav(context, 'My Profile', AppImages.profileUnselected,
                      () {
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) => const EmptyScreen(),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  bottomnav(context, 'Setting', AppImages.setting, () {
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) => const EmptyScreen(),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 25
                  ),
                  bottomnav(context, 'Wallet', AppImages.wallet, () {
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) => const WalletScreen(),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  bottomnav(context, 'Log Out', AppImages.logout, () {
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) => const EmptyScreen(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomnav(
      BuildContext context, String name, String image, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xffF6F7F9),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 30,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image))),
            ),
            const SizedBox(
              width: 30,
            ),
            ForText(
              name: name,
              size: 20,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
        //color: const Color(0xffF6F7F9),
      ),
    );
  }

  Container middelItems(BuildContext context, String? text, String image) {
    return Container(
      height: 80,
      width: 173,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(image),
            )),
          ),
          ForText(
            name: text!,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget uperscreen(BuildContext context, String name, String imageURL) {
    return Container(
      height: 220,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 64,
            backgroundImage: imageURL.isEmpty ? null : NetworkImage(imageURL),
            child: imageURL.isEmpty
                ? const Icon(Icons.person, size: 80, color: Colors.grey)
                : null,
          ),
          const SizedBox(
            height: 10,
          ),
          ForText(
            name: name,
            size: 20,
            bold: true,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
