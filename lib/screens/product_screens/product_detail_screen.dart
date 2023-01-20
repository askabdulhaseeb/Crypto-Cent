import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import '../../../widgets/custom_widgets/custom_rating_star.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../database/app_user/auth_method.dart';
import '../../function/crypto_function.dart';
import '../../function/report_bottom_sheets.dart';
import '../../models/app_user/app_user.dart';
import '../../models/product/product_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_widgets/custom_dialog.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/product/add_to_cart_widget.dart';
import '../../widgets/product/product_url_slider.dart';
import '../../widgets/product/send_offer_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.product, super.key});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider userPro, _) {
            final AppUser user = userPro.user(widget.product.uid);
            return Row(
              children: <Widget>[
                CustomProfileImage(imageURL: user.imageURL ?? '', radius: 24),
                const SizedBox(width: 10),
                Text(
                  user.name ?? 'null',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          if (widget.product.uid != AuthMethods.uid &&
              AuthMethods.uid.isNotEmpty)
            CircleAvatar(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              child: IconButton(
                  onPressed: () => ReportBottomSheets()
                      .productReport(context, widget.product),
                  icon: Icon(
                    Icons.report,
                    color: Theme.of(context).errorColor,
                  )),
            ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProductURLsSlider(urls: widget.product.prodURL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  Text(
                    widget.product.productname,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomRatingBar(
                            itemSize: 24,
                            initialRating: 5,
                            onRatingUpdate: (_) {},
                          ),
                          const ForText(
                            name: '(0 reviews)',
                            size: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '\$ ${widget.product.amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          FutureBuilder<double>(
                              future: CryptoFunction()
                                  .btcPrinceLive(dollor: widget.product.amount),
                              builder: (BuildContext context,
                                  AsyncSnapshot<double> exchangeRate) {
                                return ForText(
                                  name: exchangeRate.hasError
                                      ? '-- ERROR --'
                                      : exchangeRate.hasData
                                          ? 'Btc: ${exchangeRate.data ?? 0}'
                                          : 'fetching ...',
                                  size: 11,
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const ForText(
                    name: 'Description',
                    bold: true,
                    size: 22,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.description.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        child: (AuthMethods.uid != widget.product.uid)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: (AuthMethods.uid.isEmpty)
                    ? CustomElevatedButton(
                        title: 'Add To Cart',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomDialogBox(
                                  title: 'To enable this function',
                                  descriptions:
                                      'Please login or create account ',
                                  text: 'Login',
                                );
                              });
                        })
                    : Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomElevatedButton(
                              title: 'Send Offer',
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              bgColor: Theme.of(context).secondaryHeaderColor,
                              onTap: () async {
                                await sendOfferBottomSheet(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomElevatedButton(
                                title: 'Add to Cart',
                                onTap: () async {
                                  await bottomSheet(context, cartPro);
                                }),
                          ),
                        ],
                      ),
              )
            : const SizedBox(),
      ),
    );
  }

  Future<dynamic> sendOfferBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) =>
          SendOfferWidget(product: widget.product),
    );
  }

  Future<dynamic> bottomSheet(
    BuildContext context,
    CartProvider cartPro,
  ) async {
    return await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) =>
          AddToCartWidget(product: widget.product, buttonText: 'Add to cart'),
    );
  }
}
