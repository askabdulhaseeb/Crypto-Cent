import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../function/rating_function.dart';
import '../../models/product/product_model.dart';
import '../../../providers/product_provider.dart';
import '../../../utilities/app_images.dart';
import '../../../widgets/custom_widgets/custom_network_image.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../models/review.dart';
import '../../screens/product_screens/product_detail_screen.dart';
import '../custom_widgets/custom_rating_star.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({required this.product, this.reviews, Key? key})
      : super(key: key);
  final Product product;
  final List<Review>? reviews;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
      ),
      child: InkWell(
        onTap: () async{
          await HapticFeedback.heavyImpact();
          Navigator.push(
              context,
              MaterialPageRoute<ProductDetailScreen>(
                builder: (BuildContext context) =>
                    ProductDetailScreen(product: product),
              ));
        },
        child: AspectRatio(
          aspectRatio: 10 / 14,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 244, 244),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CustomNetworkImage(
                          imageURL: product.prodURL[0].url,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
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
                      // if (reviews == null)
                      //   Row(
                      //     children: <Widget>[
                      //       const SizedBox(width: 6),
                      //       CustomRatingBar(
                      //         itemSize: 14,
                      //         initialRating: ReviewFunction().rating(reviews!),
                      //         onRatingUpdate: (_) {},
                      //         isPadding: false,
                      //       ),
                      //       const SizedBox(width: 6),
                      //       ForText(
                      //         name: '(${reviews!.length} reviews)',
                      //         size: 11,
                      //         color: Colors.grey,
                      //       ),
                      //     ],
                      //   ),
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
          ),
        ),
      ),
    );
  }
}
