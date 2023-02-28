import 'package:crypto_cent/policies_pages/term_and_condition_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/app_user/auth_method.dart';
import 'database/local_data.dart';
import 'firebase_options.dart';
import 'pages/support_page.dart';
import 'policies_pages/accebtable_use_policy_page.dart';
import 'policies_pages/cookie_policy.dart';
import 'policies_pages/disclaimer_page.dart';
import 'policies_pages/privacy_policy.dart';
import 'policies_pages/return_policy_page.dart';
import 'policies_pages/shipping_and_delivery_policy_page.dart';
import 'policies_pages/shipping_delivery.dart';
import 'policies_pages/user_license_page.dart';
import 'providers/provider.dart';
import 'providers/providers_list.dart';

import 'screens/auth/signin_screen/signin_screen.dart';
import 'screens/auth/signup_screen/signup_screen.dart';
import 'screens/auth/welcome_screen/welcome_screen.dart';
import 'screens/category_screens/category.dart';
import 'screens/screens.dart';

Future<void> _firebaseMessBackgroundHand(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification == null) return;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalData.init();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessBackgroundHand);
  // await NotificationsServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: listOfProvider,
      child: Consumer<AppThemeProvider>(
          builder: (BuildContext context, AppThemeProvider theme, _) {
        return MaterialApp(
          title: 'Boloodo',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: theme.themeMode,
          // home: const MainScreen(),
          home: AuthMethods.getCurrentUser == null
              ? const WelcomeScreen()
              : const MainScreen(),
          // home: const NotificationScreen(),
          routes: <String, WidgetBuilder>{
            EmptyScreen.routeName: (_) => const EmptyScreen(),
            // AUTH
            WelcomeScreen.routeName: (_) => const WelcomeScreen(),
            SignInScreen.routeName: (_) => const SignInScreen(),
            SignupScreen.routeName: (_) => const SignupScreen(),
            PhoneNumberScreen.routeName: (_) => const PhoneNumberScreen(),
            MainScreen.routeName: (_) => const MainScreen(),
            AddProductScreen.routeName: (_) => const AddProductScreen(),
            // PROFILE
            PaymentScreen.routeName: (_) => const PaymentScreen(),
            CategoryScreen.routeName: (_) => const CategoryScreen(),
            LocationScreen.routeName: (_) => const LocationScreen(text: ''),
            SellingScreen.routeName: (_) => const SellingScreen(),
            // CHAT
            CreateChatGroupScreen.routeName: (_) =>
                const CreateChatGroupScreen(),
                AcceptableUserPolicy.routeName: (_) => const AcceptableUserPolicy(),
        CookiesPolices.routeName: (_) => const CookiesPolices(),
        DisclaimerPage.routeName: (_) => const DisclaimerPage(),
        PrivacyPolicy.routeName: (_) => const PrivacyPolicy(),
        ReturnPolicyPage.routeName: (_) => const ReturnPolicyPage(),
        ShippingAndDeliveryPolicyPage.routeName: (_) =>
            const ShippingAndDeliveryPolicyPage(),
        ShippingandDelivery.routeName: (_) => const ShippingandDelivery(),
        TermAndConditionPage.routeName: (_) => const TermAndConditionPage(),
        UserLicensePage.routeName: (_) => const UserLicensePage(),
        SupportPage.routePath: (_) =>  SupportPage(),
          },
        );
      }),
    );
  }
}

// flutter build web
// firebase deploy --only hosting
// Figma File
//https://www.figma.com/file/9ictqL5CrszrXY302KBqDa/Cryptocent?node-id=27%3A4835
