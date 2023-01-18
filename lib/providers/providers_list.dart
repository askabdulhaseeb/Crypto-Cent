import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_provider.dart';
import 'location_provider.dart';
import 'provider.dart';

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
      ChangeNotifierProvider<LocationProvider>.value(
        value: LocationProvider(),
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
      ChangeNotifierProvider<ContactProvider>.value(
        value: ContactProvider(),
      ),
    ];
