import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../widgets/favorite/empty_favorite_widget.dart';
import '../../widgets/favorite/fill_favorite_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  static const String routeName = '/fav-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favorite')),
      body: Consumer<ProductProvider>(
          builder: (BuildContext context, ProductProvider prodPro, _) {
        final List<String> favList = prodPro.favorites;
        return favList.isEmpty
            ? const EmptyFavotieWidget()
            : const FillFavoriteWidget();
      }),
    );
  }
}
