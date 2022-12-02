import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/app_user/auth_method.dart';
import 'database/local_data.dart';
import 'firebase_options.dart';
import 'providers/provider.dart';
import 'screens/screens.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) => UserProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (BuildContext context) => CartProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(),
        ),
        ChangeNotifierProvider<AppThemeProvider>.value(
          value: AppThemeProvider(),
        ),
        ChangeNotifierProvider<CategoriesProvider>.value(
          value: CategoriesProvider(),
        ),
        ChangeNotifierProvider<WalletProvider>.value(
          value: WalletProvider(),
        ),
        ChangeNotifierProvider<AppProvider>.value(
          value: AppProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider<BinanceProvider>.value(
          value: BinanceProvider(),
        ),
        ChangeNotifierProvider<PaymentProvider>.value(
          value: PaymentProvider(),
        ),
        ChangeNotifierProxyProvider<PaymentProvider, WalletProvider>(
          create: (_) => WalletProvider(),
          update: (_, PaymentProvider paymentPro, WalletProvider? walletPro) =>
              walletPro!..update(paymentPro),
        ),
        ChangeNotifierProvider<ChatPageProvider>.value(
          value: ChatPageProvider(),
        ),
      ],
      child: Consumer<AppThemeProvider>(
          builder: (BuildContext context, AppThemeProvider theme, _) {
        return MaterialApp(
          title: 'Crypto Cent',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: theme.themeMode,
          home: (AuthMethods.uid.isEmpty)
              ? const WelcomeScreen()
              : const MainScreen(),
          routes: <String, WidgetBuilder>{
            SigninWithEmailScreen.routeName: (_) =>
                const SigninWithEmailScreen(),
            SignupWithEmailScreen.routeName: (_) =>
                const SignupWithEmailScreen(),
            PhoneNumberScreen.routeName: (_) => const PhoneNumberScreen(),
          },
        );
      }),
    );
  }
}

// Figma File
//https://www.figma.com/file/9ictqL5CrszrXY302KBqDa/Cryptocent?node-id=27%3A4835
