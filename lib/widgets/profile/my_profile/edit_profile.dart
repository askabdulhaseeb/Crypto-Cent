import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user/app_user.dart';
import '../../../providers/user_provider.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_textform_field_withHeader.dart';
import '../../custom_widgets/cutom_text.dart';
import '../../custom_widgets/show_loading.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({required this.me, super.key});
  final AppUser me;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController firstName;
  late TextEditingController phoneNo;
  late TextEditingController googleAccount;
  bool isLoading = false;
  @override
  void initState() {
    firstName = TextEditingController(text: widget.me.name);
    phoneNo = TextEditingController(text: widget.me.phoneNumber.completeNumber);
    googleAccount = TextEditingController(
        text: widget.me.email!.isEmpty ? 'boloodo@gmail.com' : widget.me.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              stackWidget(width, context, widget.me.imageURL!, widget.me.name!),
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
                      readOnly: true,
                      color: const Color(0xffF6F7F9),
                      hintColor: Colors.grey,
                    ),
                    CustomTextFormFieldWithHeader(
                      headerText: 'Phone number',
                      controller: phoneNo,
                      readOnly: true,
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
                child: isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Update',
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          widget.me.name = firstName.text;
                          Provider.of<UserProvider>(context, listen: false)
                              .updateProfile(widget.me);
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
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
