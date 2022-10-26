import 'dart:developer';

import 'package:encrypt/encrypt.dart';

import '../database/app_user/auth_method.dart';

class Encryption {
 static final key = Key.fromLength(32);
  final iv = IV.fromLength(16);

  final Encrypter encrypter = Encrypter(AES(key));

  String appEncrypt(String data) {
   
    final Encrypted encrypted = encrypter.encrypt(data, iv: iv);
    final String encrypted64 = encrypted.base64;
    log(encrypted64);
    return encrypted64;
  }

  String appDecrypt(String encrypted) {
    final String decrypted64 = encrypter.decrypt64(encrypted, iv: iv);

    return decrypted64;
  }
}
