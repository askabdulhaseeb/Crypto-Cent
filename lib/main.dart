import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/app_user/auth_method.dart';
import 'database/local_data.dart';
import 'database/notification_services.dart';
import 'firebase_options.dart';
import 'providers/provider.dart';
import 'providers/providers_list.dart';

import 'screens/screens.dart';

Future<void> _firebaseMessBackgroundHand(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification == null) return;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalData.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessBackgroundHand);
  await NotificationsServices.init();
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

          home: AuthMethods.uid.isEmpty
              ? const PhoneNumberScreen()
              : const MainScreen(),

          // home: const NotificationScreen(),
          routes: <String, WidgetBuilder>{
            EmptyScreen.routeName: (_) => const EmptyScreen(),
            // AUTH
           
            SigninWithEmailScreen.routeName: (_) =>
                const SigninWithEmailScreen(),
            SignupWithEmailScreen.routeName: (_) =>
                const SignupWithEmailScreen(),
            PhoneNumberScreen.routeName: (_) => const PhoneNumberScreen(),
            MainScreen.routeName: (_) => const MainScreen(),
            AddProductScreen.routeName: (_) => const AddProductScreen(),
            // PROFILE
           
            LocationScreen.routeName: (_) => const LocationScreen(text: ''),
            SellingScreen.routeName: (_) => const SellingScreen(),
            // CHAT
            CreateChatGroupScreen.routeName: (_) =>
                const CreateChatGroupScreen(),
          },
        );
      }),
    );
  }
}

// Figma File
//https://www.figma.com/file/9ictqL5CrszrXY302KBqDa/Cryptocent?node-id=27%3A4835
