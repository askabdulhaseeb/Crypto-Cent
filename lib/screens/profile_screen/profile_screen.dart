import 'package:flutter/material.dart';

import '../../database/app_user/auth_method.dart';
import '../../utilities/app_images.dart';
import '../../widgets/profile/profile_header.dart';
import '../../widgets/profile/profile_middle_tile.dart';
import '../../widgets/profile/profile_nav_tile.dart';
import '../auth/welcome_screen.dart';
import '../empty_screen/empty_screen.dart';
import '../order/order_history.dart';
import 'wallet/wallet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const ProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          // ignore: always_specify_types
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const OrderHistory(),
                          ),
                        );
                      },
                      child: ProfileMiddleTile(
                        text: 'My Order\nHistory',
                        image: AppImages.orderhistory,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProfileMiddleTile(
                      text: 'Delivery\nAddress',
                      image: AppImages.deliveryaddress,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  ProfileNavTile(
                      name: 'My Profile',
                      image: AppImages.profileUnselected,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<EmptyScreen>(
                            builder: (BuildContext context) =>
                                const EmptyScreen(),
                          ),
                        );
                      }),
                  const SizedBox(height: 24),
                  ProfileNavTile(
                      name: 'Setting',
                      image: AppImages.setting,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<EmptyScreen>(
                            builder: (BuildContext context) =>
                                const EmptyScreen(),
                          ),
                        );
                      }),
                  const SizedBox(height: 24),
                  ProfileNavTile(
                      name: 'Wallet',
                      image: AppImages.wallet,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<WalletScreen>(
                            builder: (BuildContext context) =>
                                const WalletScreen(),
                          ),
                        );
                      }),
                  const SizedBox(height: 24),
                  ProfileNavTile(
                    name: 'Selling',
                    image: AppImages.bitcoinIcon,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<EmptyScreen>(
                        builder: (BuildContext context) => const EmptyScreen(),
                      ));
                    },
                  ),
                  const SizedBox(height: 24),
                  ProfileNavTile(
                    name: 'Log Out',
                    image: AppImages.logout,
                    onTap: () async {
                      await AuthMethods().signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          WelcomeScreen.routeName,
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
