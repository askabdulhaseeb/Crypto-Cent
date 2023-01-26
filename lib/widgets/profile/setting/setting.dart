import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../screens/auth/welcome_screen.dart';
import '../../../screens/empty_screen/empty_screen.dart';
import '../../../screens/map_screen/add_new_address.dart';
import '../../../screens/map_screen/location_screen.dart';
import '../../../utilities/app_images.dart';
import '../my_profile/edit_profile.dart';
import '../profile_nav_tile.dart';
import 'change_password.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              ProfileNavTile(
                name: 'Change Password',
                onTap: () async {
                  await HapticFeedback.heavyImpact();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ChnagePassword(),
                  ));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileNavTile(
                name: 'Edit Address',
                onTap: () async {
                  await HapticFeedback.heavyImpact();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AddNewAddress(isProduct: false),
                  ));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileNavTile(
                name: 'Location',
                onTap: () async {
                  await HapticFeedback.heavyImpact();
                  Navigator.of(context).push(MaterialPageRoute<EmptyScreen>(
                    builder: (BuildContext context) => const LocationScreen(
                      text: 'location',
                    ),
                  ));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileNavTile(
                name: 'Profile Setting',
                onTap: () async {
                  await HapticFeedback.heavyImpact();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const EditProfile(),
                  ));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // ProfileNavTile(
              //   name: 'Deactive Account',
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (BuildContext context) => DeleteAccount(),
              //     ));
              //   },
              // ),

              ProfileNavTile(
                name: 'Log Out',
                image: AppImages.logout,
                onTap: () async {
                  await HapticFeedback.heavyImpact();
                  await AuthMethods().signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      WelcomeScreen.routeName, (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ));
  }
}
