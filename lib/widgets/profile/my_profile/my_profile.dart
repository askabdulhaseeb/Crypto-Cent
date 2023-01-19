import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider.dart';
import '../../custom_widgets/custom_widget.dart';
import '../profile_header.dart';
import 'edit_profile.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userPro = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const ProfileHeader(),
            tilewidget(
                context: context,
                text: userPro.currentUser.name,
                icon: Icons.person),
            tilewidget(
                context: context,
                text: userPro.currentUser.email!.isEmpty
                    ? 'Boloodo@gmail.com'
                    : userPro.currentUser.email,
                icon: Icons.email),
            tilewidget(
                context: context,
                text: userPro.currentUser.phoneNumber.completeNumber,
                icon: Icons.phone),
            tilewidget(
                context: context,
                text: 'Model town lahore',
                icon: Icons.location_on),
            tilewidget(context: context, text: 'Reviews', icon: Icons.reviews),
            tilewidget(
                context: context, text: 'Feedback', icon: Icons.rss_feed_sharp),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: CustomElevatedButton(
                  title: 'Update Profile',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<EditProfile>(
                      builder: (BuildContext context) => const EditProfile(),
                    ));
                  }),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget tilewidget({BuildContext? context, String? text, IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffF6F7F9),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
      child: ListTile(
        leading: Icon(
          icon!,
          color: Theme.of(context!).primaryColor,
        ),
        title: ForText(
          name: text!,
          bold: true,
        ),
      ),
    );
  }
}
