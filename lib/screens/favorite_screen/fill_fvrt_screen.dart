import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../home_screen/list_view/list_view_extend.dart';

class FillFvrtScreen extends StatefulWidget {
  const FillFvrtScreen({super.key});

  @override
  State<FillFvrtScreen> createState() => _FillFvrtScreenState();
}

class _FillFvrtScreenState extends State<FillFvrtScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> favList = Provider.of<ProductProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorite')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 500 ? 3 : 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: favList.length,
          itemBuilder: (BuildContext context, int index) => ListViewScreen(
            product:
                Provider.of<ProductProvider>(context, listen: false).product(
              favList[index],
            ),
          ),
        ),
      ),
    );
  }
}
