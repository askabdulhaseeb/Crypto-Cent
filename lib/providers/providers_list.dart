
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_provider.dart';
import 'app_theme.dart';
import 'auth_provider.dart';
import 'cart_provider.dart';
import 'categories_provider.dart';
import 'crypto_wallet/binance_provider.dart';
import 'crypto_wallet/wallet_provider.dart';
import 'payment/payment_provider.dart';
import 'product_provider.dart';
import 'provider.dart';
import 'user_provider.dart';



// ignore: always_specify_types
dynamic get listOfProvider => [
     
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
    ];


