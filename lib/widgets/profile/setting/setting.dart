import 'package:flutter/material.dart';

import '../../../screens/empty_screen/empty_screen.dart';
import '../../../screens/map_screen/add_new_address.dart';
import '../../../screens/map_screen/location_screen.dart';
import '../my_profile/edit_profile.dart';
import '../profile_nav_tile.dart';
import 'change_password.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
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
                onTap: () {
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
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddNewAddress(isProduct: false),
                  ));
                  
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileNavTile(
                name: 'Location',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<EmptyScreen>(
                    builder: (BuildContext context) => const LocationScreen(text: 'location',),
                  ));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileNavTile(
                name: 'Profile Setting',
                onTap: () {
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
            ],
          ),
        ));
  }
}
