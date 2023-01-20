import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/categories_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import 'categories_extend.dart';

class SomeCategories extends StatelessWidget {
  const SomeCategories({super.key});
  static const String routeName = '/category-screen';

  @override
  Widget build(BuildContext context) {
    CategoriesProvider catPro = Provider.of<CategoriesProvider>(context);
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      childAspectRatio: 90 / 110,
      mainAxisSpacing: 8,
      crossAxisCount: 2,
      // ignore: always_specify_types
      children: List.generate(catPro.someCategories.length, (int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<CategoriesExtend>(
                  builder: (BuildContext context) => CategoriesExtend(
                        categoryName: catPro.someCategories[index].catID,
                      )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: const Color.fromARGB(255, 239, 239, 239),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  catPro.someCategories[index].imageURl),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: ForText(
                        name: catPro.someCategories[index].title,
                        color: Colors.black,
                        bold: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
