import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/app_user/auth_method.dart';
import '../../models/product/product_model.dart';
import '../../providers/provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/cutom_text.dart';
import '../../widgets/product/product_tile/product_tile.dart';
import '../product_screens/add_product_screen.dart';

class SellingScreen extends StatelessWidget {
  const SellingScreen({Key? key}) : super(key: key);
  static const String routeName = 'selling_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Selling Screen')),
        body: Consumer<ProductProvider>(
          builder: (
            BuildContext context,
            ProductProvider prodPro,
            _,
          ) {
            final List<Product> prods = prodPro.productByUID(AuthMethods.uid);
            return prods.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                            child: Image.asset(AppImages.bitcoinIcon),
                          ),
                          const SizedBox(height: 8),
                          const ForText(name: 'Selling is empty', bold: true),
                          const SizedBox(height: 16),
                          const Text(
                            '''You didn't add anything to sell yet, please add anything to sell and earn money''',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton.icon(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AddProductScreen.routeName),
                            icon: SizedBox(
                              height: 20,
                              child: Image.asset(AppImages.bitcoinIcon),
                            ),
                            label: const Text('click here to add in product'),
                          ),
                        ],
                      ),
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 500 ? 3 : 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: 200 / 250),
                    itemCount: prods.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductTile(
                      product: prods[index],
                    ),
                  );
          },
        ));
  }
}
