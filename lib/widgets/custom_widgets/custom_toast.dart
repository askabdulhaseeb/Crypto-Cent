import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void successToast({required String message, int duration = 3}) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: duration,
      backgroundColor: Colors.green,
    );
  }

  static void errorToast({required String message, int duration = 4}) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: duration,
      backgroundColor: Colors.red,
    );
  }
static void successDialogeBox({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xff00E676),
                  borderRadius: kDefaultBorderRadius,
                  boxShadow: kDefaultBoxShadow,
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: -10,
                      left: -8,
                      child: SizedBox(
                        height: 50,
                        child: Transform.rotate(
                          angle: 32 * pi / 180,
                          child: const Icon(
                            Icons.sentiment_very_satisfied,
                            color: Color(0x15000000),
                            size: 120,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
  static void errorSnackBar({
    required BuildContext context,
    required String text,
  }) {
    final SnackBar snackBar =
        SnackBar(content: Text(text), backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void successSnackBar({
    required BuildContext context,
    required String text,
  }) {
    final SnackBar snackBar =
        SnackBar(content: Text(text), backgroundColor: Colors.green);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void alertDialogeBox({
    required BuildContext context,
    required String text,
  }) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(text),
            //content: Text('Do you really want to delete?'),
          );
        });
  }
}
const kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 8),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(12));
