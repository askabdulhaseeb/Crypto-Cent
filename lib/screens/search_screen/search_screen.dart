import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/product/product_model.dart';
import '../../providers/product_provider.dart';
import '../product_screens/product_detail_screen.dart';

class SerachScreen extends StatelessWidget {
  const SerachScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    ProductProvider productPro = Provider.of<ProductProvider>(context);
    List<Product> products = productPro.forSearch();
    return SizedBox(
      height: height * 0.65,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Items Search'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: const Color.fromARGB(255, 66, 66, 66)
                              .withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search...'),
                      // onChanged: (String val) => testPro.onSearch(val),
                      onChanged: (String val) => productPro.onSearch(val),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () async{
                      await HapticFeedback.heavyImpact();
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute<ProductDetailScreen>(
                            builder: (BuildContext context) =>
                                ProductDetailScreen(product: products[index]),
                          ));
                    },
                    title: Text(
                      products[index].productname,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
