import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product/product_model.dart';
import '../../../providers/product_provider.dart';
import '../../../utilities/app_images.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/product/extend_product_tile.dart';

class MobileCategoryExtend extends StatefulWidget {
  MobileCategoryExtend({
    required this.categoryName,
    super.key,
  });
String categoryName;
  @override
  State<MobileCategoryExtend> createState() => _MobileCategoryExtendState();
}

class _MobileCategoryExtendState extends State<MobileCategoryExtend> {
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
    double width = MediaQuery.of(context).size.width*0.6;
    List<Product> products = <Product>[];
    if (widget.categoryName == 'All') {
      products = prouctPro.products;
    } else {
      products = prouctPro.findByCategory(widget.categoryName);
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextFormField(
              starticon: Icons.search,
              hint: 'Search ...',
              color: Colors.white,
              controller: _searchController,
              onChanged: (String p0) {
                prouctPro.onCatSearch(p0);
              },
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
              child: GridView.count(
                childAspectRatio: 200 / 330,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
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
  
                  return ExtendProductTile(product: products[index],width: width,);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
