
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../function/web_appbar.dart';
import '../../../models/product/product_model.dart';
import '../../../providers/product_provider.dart';
import '../../../utilities/app_images.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/footer_widget.dart';
import '../../../widgets/product/extend_product_tile/web_extend_product_tile.dart';
import '../../../widgets/product/web_extend_product_tile.dart';

class WebCategoryExtend extends StatefulWidget {
 WebCategoryExtend({
    required this.categoryName,
    super.key,
  });
 String categoryName;

  @override
  State<WebCategoryExtend> createState() => _WebCategoryExtendState();
}

class _WebCategoryExtendState extends State<WebCategoryExtend> {
  final TextEditingController _searchController = TextEditingController();

  List<String> dropDownItem = [
    'Sort by Date',
    'Price Low To High',
    'Price High To Low',
  ];

  String selectedItem = 'Sort by Date';
  @override
  Widget build(BuildContext context) {
    ProductProvider prouctPro = Provider.of<ProductProvider>(context);
    double width = MediaQuery.of(context).size.width*0.2;
    List<Product> products = <Product>[];
    if (widget.categoryName == 'All') {
      products = prouctPro.products;
    } else {
      products = prouctPro.findByCategory(widget.categoryName);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
          child: Scaffold(
            
            appBar:  WebAppBar().webAppBar(context),
            body: Column(
              children: [
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Text(
               widget.categoryName,
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),
              ),
                      SizedBox(
                        width: 300,
                        child: CustomTextFormField(
                          starticon: Icons.search,
                          hint: 'Search ...',
                          color: Colors.white,borderRadius: 8,
                          controller: _searchController,
                          onChanged: (String p0) {
                            prouctPro.onCatSearch(p0);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(AppImages.filtterIcon),
                          ),
                        ),
                        value: selectedItem,
                        items: dropDownItem
                            .map((String e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedItem = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.count(
                            childAspectRatio: 200 / 330,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            shrinkWrap: true,
                            crossAxisCount: 4 ,
                            children: List<Widget>.generate(products.length, (int index) {
                              if (selectedItem == 'Price Low To High') {
                                products.sort(
                                  (Product a, Product b) => a.amount.compareTo(b.amount),
                                );
                              } else if (selectedItem == dropDownItem[2]) {
                                products.sort(
                                  (Product b, Product a) => a.amount.compareTo(b.amount),
                                );
                              }
                              
                              return WebExtendProductTile(product: products[index]);
                            }),
                          ),
                         const FooterWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
