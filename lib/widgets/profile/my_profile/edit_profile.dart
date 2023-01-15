import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_textform_field_withHeader.dart';
import '../../custom_widgets/cutom_text.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  // final TextEditingController _firstName =
  @override
  Widget build(BuildContext context) {
    UserProvider userPro = Provider.of<UserProvider>(context);
    final TextEditingController firstName =
        TextEditingController(text: userPro.currentUser.name);
    final TextEditingController phoneNo = TextEditingController(
        text: userPro.currentUser.phoneNumber.completeNumber);
    final TextEditingController googleAccount = TextEditingController(
        text: userPro.currentUser.email!.isEmpty
            ? 'boloodo@gmail.com'
            : userPro.currentUser.email);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              stackWidget(width, context, userPro.currentUser.imageURL!,
                  userPro.currentUser.name!),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    CustomTextFormFieldWithHeader(
                      headerText: 'First Name',
                      controller: firstName,
                      Boardercolor: Colors.transparent,
                      color: const Color(0xffF6F7F9),
                      hintColor: Colors.grey,
                    ),
                    CustomTextFormFieldWithHeader(
                      headerText: 'Email',
                      controller: googleAccount,
                      Boardercolor: Colors.transparent,
                      color: const Color(0xffF6F7F9),
                      hintColor: Colors.grey,
                    ),
                    CustomTextFormFieldWithHeader(
                      headerText: 'Phone number',
                      controller: phoneNo,
                      Boardercolor: Colors.transparent,
                      color: const Color(0xffF6F7F9),
                      hintColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: CustomElevatedButton(
                  title: 'Update',
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   // ignore: always_specify_types
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => ChnagePassword(),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget stackWidget(
      double width, BuildContext context, String imageURL, String name) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 192,
            width: width,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: width * 0.25,
                ),
                const ForText(name: 'Edit Profile', bold: true, size: 20),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage:
                      imageURL.isEmpty ? null : NetworkImage(imageURL),
                  child: imageURL.isEmpty
                      ? const Icon(Icons.person, size: 80, color: Colors.grey)
                      : null,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ForText(name: name, size: 20),
          ],
        )
      ],
    );
  }
}
