import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../widgets/custom_widgets/cutom_text.dart';

class EmptyFvrtScreen extends StatelessWidget {
  const EmptyFvrtScreen({super.key});
  static const String routeName = '/EmptyFvrtScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.favorite_border,
              size: 52,
              color: Colors.grey,
            ),
            const SizedBox(height: 8),
            const ForText(name: 'Favorite is empty', bold: true),
            const SizedBox(height: 16),
            const Text(
              'To buy anything you have to add products in the favorite, currently their is nothing in the favorite to display',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            TextButton.icon(
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
              },
              icon: const Icon(Icons.favorite_border),
              label: const Text('click here to add in favorite'),
            ),
          ],
        ),
      ),
    );
  }
}
