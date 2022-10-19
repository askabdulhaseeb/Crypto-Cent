import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class AuthProvider with ChangeNotifier {
  onPhoneNumberChange(PhoneNumber? value) {
    _phoneNumber = value;
    notifyListeners();
  }

  //verifyphone with code
  Future<void> verifyPhone(BuildContext context) async {
    if (_phoneNumber == null) return;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneNumber!.completeNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        // _smsOTP = phoneAuthCredential.smsCode;
        _verificationId = phoneAuthCredential.verificationId;
      },
      verificationFailed: (FirebaseAuthException verificationFailed) async {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(verificationFailed.message!)));
      },
      codeSent: (String verificationId, int? resendingToken) async {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    notifyListeners();
  }

  PhoneNumber? _phoneNumber;
  String? _verificationId;

  PhoneNumber? get phoneNumber => _phoneNumber;
}
