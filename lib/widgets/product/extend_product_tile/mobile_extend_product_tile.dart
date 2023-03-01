import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/product/product_model.dart';
import '../../../providers/product_provider.dart';
import '../../../screens/product_screens/product_deatil/mobile_product_detail_screen.dart';
import '../../../screens/product_screens/product_deatil/product_detail_screen.dart';
import '../../../utilities/app_images.dart';
import '../../../widgets/custom_widgets/custom_network_image.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';


class MobileExtendProductTile extends StatelessWidget {
  MobileExtendProductTile({required this.product,Key? key}) : super(key: key);
  final Product product;
 
  @override
  Widget build(BuildContext context) {
    double width = 400;
    return InkWell(
      onTap: () async{
        await HapticFeedback.heavyImpact();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute<ProductDetailScreen>(
              builder: (BuildContext context) =>
                  ProductDetailScreen(product: product),
            ));
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            height: width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 244, 244),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image(image: NetworkImage( product.prodURL[0].url),fit: BoxFit.fill,),
           
          ),
          SizedBox(
                  height: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          product.productname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 6),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          const ForText(
                            name: '0 Review',
                            size: 11,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '\$${product.amount}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Consumer<ProductProvider>(builder:
                                (BuildContext context,
                                    ProductProvider productPro, _) {
                              return Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    productPro.updateFavorite(product.pid);
                                  },
                                  icon: (productPro.favorites
                                          .contains(product.pid))
                                      ? Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  AppImages.fvrtSelected),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  AppImages.fvrtUnselected),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
