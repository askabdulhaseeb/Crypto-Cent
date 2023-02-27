import 'package:flutter/material.dart';

import '../../screens/auth/welcome_screen/welcome_screen.dart';
import '../../utilities/app_images.dart';
import '../../utilities/utilities.dart';
import 'constants.dart';
import 'custom_elevated_button.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({
    required this.text,
    required this.title,
    required this.descriptions,
    Key? key,
  }) : super(key: key);
  final String title, descriptions, text;

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: Utilities.tabMaxWidth / 2),
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomElevatedButton(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<WelcomeScreen>(
                          builder: (BuildContext context) =>
                              const WelcomeScreen(),
                        ),
                        (Route route) => false);
                  },
                  title: widget.text,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 60,
          right: 60,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.avatarRadius)),
                child: Image.asset(AppImages.logo)),
          ),
        ),
      ],
    );
  }
}
