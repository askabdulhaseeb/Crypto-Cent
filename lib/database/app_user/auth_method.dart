import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/app_user/app_user.dart';
import '../../models/app_user/numbers_detail.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import 'user_api.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get getCurrentUser => _auth.currentUser;

  static String get uid => _auth.currentUser?.uid ?? '';
  static String get phoneNumber => _auth.currentUser?.phoneNumber ?? '';

  Future<int> verifyOTP(String verificationId, String otp) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final UserCredential authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        final AppUser? appUser =
            await UserApi().user(uid: authCredential.user!.uid);
        if (appUser == null) return 0; // User is New on App
        return 1; // User Already Exist NO new info needed
      }
      return -1; // ERROR while Entering OTP
    } catch (ex) {
      CustomToast.errorToast(message: ex.toString());
      return -1;
    }
  }

  Future<int> signinWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final UserCredential authResult = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          final User user = authResult.user!;
          final AppUser? alreadySignin = await UserApi().user(uid: user.uid);
          if (alreadySignin == null) {
            return 0;
          } else {
            return 1;
          }
        } catch (error) {
          CustomToast.errorToast(message: error.toString());
        }
      }
    }
    return -1;
  }

  Future<User?>? signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);
      final AppUser myUser = AppUser(
        uid: uid,
        name: name,
        phoneNumber: NumberDetails(
          completeNumber: '',
          countryCode: '',
          isoCode: '',
          number: '',
          timestamp: 0,
        ),
      );
      if (user != null) {
        await UserApi().register(user: myUser);
      }
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
