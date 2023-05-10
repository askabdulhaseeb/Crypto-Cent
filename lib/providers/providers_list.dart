import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notification_provider.dart';
import 'provider.dart';

// ignore: always_specify_types
dynamic get listOfProvider => [
      ChangeNotifierProvider<UserProvider>(
        create: (BuildContext context) => UserProvider(),
      ),
      ChangeNotifierProvider<CartProvider>(
        create: (BuildContext context) => CartProvider(),
      ),
      ChangeNotifierProvider<NotificationProvider>(
        create: (BuildContext context) => NotificationProvider(),
      ),
      ChangeNotifierProvider<AddProductProvider>(
        create: (BuildContext context) => AddProductProvider(),
      ),
      ChangeNotifierProvider<AuthProvider>(
        create: (BuildContext context) => AuthProvider(),
      ),
      ChangeNotifierProvider<RatingProvider>(
        create: (BuildContext context) => RatingProvider(),
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
     
      ChangeNotifierProvider<AppProvider>.value(
        value: AppProvider(),
      ),
      ChangeNotifierProvider<ProductProvider>.value(
        value: ProductProvider(),
      ),
      ChangeNotifierProvider<BinanceProvider>.value(
        value: BinanceProvider(),
      ),
     
      ChangeNotifierProvider<ChatPageProvider>.value(
        value: ChatPageProvider(),
      ),
      ChangeNotifierProvider<ContactProvider>.value(
        value: ContactProvider(),
      ),
    
    ];
