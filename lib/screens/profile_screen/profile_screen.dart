import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../database/app_user/auth_method.dart';
import '../../utilities/app_images.dart';
import '../../widgets/profile/my_profile/my_profile.dart';
import '../../widgets/profile/order/orders.dart';
import '../../widgets/profile/profile_header.dart';
import '../../widgets/profile/profile_middle_tile.dart';
import '../../widgets/profile/profile_nav_tile.dart';
import '../../widgets/profile/setting/setting.dart';
import '../auth/welcome_screen.dart';
import '../empty_screen/empty_screen.dart';
import '../empty_screen/empty_auth_screen.dart';
import '../map_screen/location_screen.dart';
import '../order/order_history.dart';
import 'selling_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthMethods.uid.isEmpty
        ? const EmptyAuthScreen(
            text: 'Please Log in to view your profile',
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.black, fontSize: 22),
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
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderTabbar(),));
                            },
                            child: ProfileMiddleTile(
                              text: 'My MyOrder\nHistory',
                              image: AppImages.orderhistory,

                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              Navigator.push(
                                context,
                                // ignore: always_specify_types
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LocationScreen(
                                          text: 'Delivery Addresses'),
                                ),
                              );
                            },
                            child: ProfileMiddleTile(
                              text: 'Delivery\nAddress',
                              image: AppImages.deliveryaddress,
                            ),
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
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              Navigator.push(
                                context,
                                MaterialPageRoute<MyProfile>(
                                  builder: (BuildContext context) =>
                                      const MyProfile(),
                                ),
                              );
                            }),
                        const SizedBox(height: 24),
                        ProfileNavTile(
                            name: 'Settings',
                            image: AppImages.setting,
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              Navigator.push(
                                context,
                                MaterialPageRoute<Setting>(
                                  builder: (BuildContext context) =>
                                      const Setting(),
                                ),
                              );
                            }),
                        const SizedBox(height: 24),
                        ProfileNavTile(
                            name: 'Orders',
                            image: AppImages.orderhistory,
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderTabbar(),));
                            }),
                        const SizedBox(height: 24),

                        const SizedBox(height: 24),
                        ProfileNavTile(
                          name: 'Selling',
                          image: AppImages.bitcoinIcon,
                          onTap: () async {
                            await HapticFeedback.heavyImpact();
                            Navigator.of(context)
                                .pushNamed(SellingScreen.routeName);
                          },
                        ),
                        const SizedBox(height: 24),
                        // ProfileNavTile(
                        //   name: 'Log Out',
                        //   image: AppImages.logout,
                        //   onTap: () async {
                        //     await HapticFeedback.heavyImpact();
                        //     await AuthMethods().signOut();
                        //     // ignore: use_build_context_synchronously
                        //     Navigator.of(context).pushNamedAndRemoveUntil(
                        //         WelcomeScreen.routeName,
                        //         (Route<dynamic> route) => false);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
