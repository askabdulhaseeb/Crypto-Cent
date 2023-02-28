
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../function/web_appbar.dart';
import '../../providers/categories_provider.dart';
import '../../widgets/custom_widgets/cutom_text.dart';
import 'categroey_extend/categories_extend.dart';

class WebCategoryScreen extends StatelessWidget {
  const WebCategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CategoriesProvider catPro = Provider.of<CategoriesProvider>(context);
    return Scaffold(
        appBar: WebAppBar.webAppBar,
        body: GridView.count(
          childAspectRatio: 96 / 118,
          mainAxisSpacing: 8,
          crossAxisCount: 4,
          // ignore: always_specify_types
          children: List.generate(catPro.categories.length, (int index) {
            return InkWell(
              onTap: () async{
                   
               //   Navigator.pushNamed(context, CategoriesExtend.routeName,arguments: ScreenArguments(catPro.categories[index].catID==null?catPro.categories[index].catID:'All'));
                Navigator.push(
                    context,
                    // ignore: always_specify_types
                    MaterialPageRoute(
                        builder: (BuildContext context) => CategoriesExtend(
                              categoryName: catPro.categories[index].catID,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: const Color.fromARGB(255, 245, 244, 244),
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
                                      catPro.categories[index].imageURl),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Center(
                          child: ForText(
                            name: catPro.categories[index].title,
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
        ));
  }
}
