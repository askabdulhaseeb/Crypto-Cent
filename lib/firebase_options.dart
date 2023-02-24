// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBda5JvmeRZje6VZQplTWtLtFkUnI-58SE',
    appId: '1:624098099021:web:b6465db26313fe43884104',
    messagingSenderId: '624098099021',
    projectId: 'bloodo-app',
    databaseURL: "https://bloodo-app.firebaseio.com",
    authDomain: 'bloodo-app.firebaseapp.com',
    storageBucket: 'bloodo-app.appspot.com',
    measurementId: 'G-8E9765HQC6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYIOTkjNEC7WuCtfcC481Kn1jZ9950fnM',
    appId: '1:624098099021:android:4b55f5f8e946810b884104',
    messagingSenderId: '624098099021',
    projectId: 'bloodo-app',
    storageBucket: 'bloodo-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCF8zARmBBzC48EPcuPBlUGsBFh5K3aem8',
    appId: '1:624098099021:ios:71d26f6ed119585b884104',
    messagingSenderId: '624098099021',
    projectId: 'bloodo-app',
    storageBucket: 'bloodo-app.appspot.com',
    androidClientId: '624098099021-bcbr43fffbsjtsc7nvgd3v9l8d2pun62.apps.googleusercontent.com',
    iosClientId: '624098099021-81tvngbk0ojq3mnla5638m5tiv23a1pa.apps.googleusercontent.com',
    iosBundleId: 'com.devmarkaz.boloodo',
  );
}
