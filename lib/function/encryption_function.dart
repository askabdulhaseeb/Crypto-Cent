import 'dart:convert';

import 'package:encrypt/encrypt.dart';

import '../database/app_user/auth_method.dart';

class Encryption {
  static String uid = AuthMethods.uid;
  static String bs64 = base64.encode(uid.codeUnits);
  static String x = bs64.substring(bs64.length - 24, bs64.length);
  static final Key key = Key.fromBase64(x);
  final IV iv = IV.fromBase64(x);

  final Encrypter encrypter = Encrypter(AES(key));

  String appEncrypt(String data) {
   
    final Encrypted encrypted = encrypter.encrypt(data, iv: iv);
    final String encrypted64 = encrypted.base64;

    return encrypted64;
  }

  String appDecrypt(String data) {
    final String decrypted64 =
        encrypter.decrypt(Encrypted.fromBase64(data), iv: iv);

    return decrypted64;
  }

  String userDecrypt(String data, String id) {
    String uidd = id;
    String bbs64 = base64.encode(uidd.codeUnits);
    String xx = bbs64.substring(bbs64.length - 24, bbs64.length);
    final Key kkey = Key.fromBase64(xx);
    final IV iiv = IV.fromBase64(xx);

    final Encrypter encrypter = Encrypter(AES(kkey));
    final String decrypted64 =
        encrypter.decrypt(Encrypted.fromBase64(data), iv: iiv);

    return decrypted64;
  }
}
