import 'package:flutter/material.dart';

import '../../../screens/empty_screen/empty_screen.dart';
import '../../custom_widgets/custom_widget.dart';
import '../my_profile/edit_profile.dart';
import '../profile_nav_tile.dart';
import 'change_password.dart';
import 'deactive_account.dart';

class Setting extends StatelessWidget {
  Setting({super.key});
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
              SizedBox(
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
              SizedBox(
                height: 20,
              ),
              ProfileNavTile(
                name: 'Edit Address',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<EmptyScreen>(
                    builder: (BuildContext context) => const EmptyScreen(),
                  ));
                },
              ),
              SizedBox(
                height: 20,
              ),
              ProfileNavTile(
                name: 'Location',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<EmptyScreen>(
                    builder: (BuildContext context) => const EmptyScreen(),
                  ));
                },
              ),
              SizedBox(
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
              SizedBox(
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
