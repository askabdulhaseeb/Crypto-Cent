import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/categories_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import 'categories_extend.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const String routeName = '/category-screen';

  @override
  Widget build(BuildContext context) {
    CategoriesProvider catPro = Provider.of<CategoriesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: GridView.count(
          childAspectRatio: 96 / 118,
          mainAxisSpacing: 8,
          crossAxisCount: 3,
          // ignore: always_specify_types
          children: List.generate(catPro.categories.length, (int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    // ignore: always_specify_types
                    MaterialPageRoute(
                        builder: (BuildContext context) => CategoriesExtend(
                              categoryName: catPro.categories[index].title,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                catPro.categories[index].imageURl)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        left: 10,
                        right: 10,
                        child: Center(
                          child: ForText(
                            name: catPro.categories[index].title,
                            color: Colors.white,
                            bold: true,
                          ),
                        ))
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
