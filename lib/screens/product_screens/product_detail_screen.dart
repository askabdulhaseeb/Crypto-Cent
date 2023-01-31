import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import '../../../widgets/custom_widgets/custom_rating_star.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../database/app_user/auth_method.dart';
import '../../database/chat_api.dart';
import '../../function/crypto_function.dart';
import '../../function/rating_function.dart';
import '../../function/report_bottom_sheets.dart';
import '../../function/unique_id_functions.dart';
import '../../models/app_user/app_user.dart';
import '../../models/chat/chat.dart';
import '../../models/location.dart';
import '../../models/product/product_model.dart';
import '../../models/review.dart';
import '../../providers/location_provider.dart';
import '../../providers/rating_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_widgets/custom_dialog.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/product/add_to_cart_widget.dart';
import '../../widgets/product/product_url_slider.dart';
import '../../widgets/product/send_offer_widget.dart';
import '../chat_screen/private/personal_chat_screen.dart';
import '../chat_screen/private/product_chat_screen.dart';
import '../../widgets/profile/other_user_profile.dart';
import '../map_screen/map_screen.dart';
import '../reviews/review_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.product, super.key});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final AppUser seller =
        Provider.of<UserProvider>(context).user(widget.product.uid);
    CartProvider cartPro = Provider.of<CartProvider>(context);
    LocationProvider locationPro = Provider.of<LocationProvider>(context);
    final UserLocation location =
        locationPro.productLocation(widget.product.locationUID);

    List<Review> reviews =
        Provider.of<RatingProvider>(context).productReviews(widget.product.pid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () async {
            await HapticFeedback.heavyImpact();
            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute<ProductDetailScreen>(
                  builder: (BuildContext context) => OtherUserProfile(
                    appUser: seller,
                  ),
                ));
          },
          child: Row(
            children: <Widget>[
              CustomProfileImage(imageURL: seller.imageURL ?? '', radius: 24),
              const SizedBox(width: 10),
              Text(
                seller.name ?? 'null',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          if (widget.product.uid != AuthMethods.uid &&
              AuthMethods.uid.isNotEmpty)
            CircleAvatar(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              child: IconButton(
                onPressed: () async {
                  if (!mounted) return;
                  Navigator.of(context).push(
                    MaterialPageRoute<PersonalChatScreen>(
                      builder: (BuildContext context) => PersonalChatScreen(
                        chat: Chat(
                            chatID: UniqueIdFunctions.personalChatID(
                                chatWith: seller.uid),
                            persons: <String>[seller.uid, AuthMethods.uid]),
                        chatWith: seller,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.chat, color: Theme.of(context).primaryColor),
              ),
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
                  GestureDetector(
                    onTap: () async {
                      await HapticFeedback.heavyImpact();
                      mapBottomSheet(context, location);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${location.city} , ${location.state}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          await HapticFeedback.heavyImpact();
                          Navigator.push(
                              context,
                              MaterialPageRoute<ReviewScreen>(
                                builder: (BuildContext context) => ReviewScreen(
                                  reviews: reviews,
                                  isProduct: true,
                                  id: widget.product.pid,
                                ),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomRatingBar(
                              itemSize: 20,
                              initialRating: ReviewFunction().rating(reviews),
                              onRatingUpdate: (_) {},
                            ),
                            ForText(
                              name: '(${reviews.length} reviews)',
                              size: 13,
                              color: Colors.grey,
                            ),
                          ],
                        ),
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
                  CustomElevatedButton(
                    title: 'Report Product',
                    bgColor: Colors.transparent,
                    border: Border.all(color: Theme.of(context).primaryColor),
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                    onTap: () async {
                      await HapticFeedback.heavyImpact();
                      ReportBottomSheets()
                          .productReport(context, widget.product);
                    },
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
        width: double.infinity,
        child: (AuthMethods.uid != widget.product.uid)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: (AuthMethods.uid.isEmpty)
                    ? CustomElevatedButton(
                        title: 'Add To Cart',
                        onTap: () async {
                          await HapticFeedback.heavyImpact();
                          // ignore: use_build_context_synchronously
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
                    // ? Container(
                    //     height: 59,
                    //     width: double.infinity,
                    //     color: Colors.red,
                    //   )
                    : Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomElevatedButton(
                              title: 'Send Offer',
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              bgColor: Theme.of(context).secondaryHeaderColor,
                              onTap: () async {
                                await HapticFeedback.heavyImpact();
                                await sendOfferBottomSheet(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomElevatedButton(
                                title: 'Add to Cart',
                                onTap: () async {
                                  await HapticFeedback.heavyImpact();
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

  Future<dynamic> mapBottomSheet(
    BuildContext context,
    UserLocation location,
  ) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.width * 1.15,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ForText(
                    name: location.address,
                    bold: true,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: location.longitude == 0
                        ? Colors.transparent
                        : Colors.black,
                  ),
                  child: location.longitude == 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.wrong_location_outlined,
                                size: 52,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ForText(
                                name: 'Location not found',
                                bold: true,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ForText(
                                name:
                                    'Location not found, please check your devices GPS settings and ensure that you have a stable internet connection',
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        )
                      : GoogleMapWidget(
                        productName: widget.product.productname,
                          latitude: location.latitude,
                          longitude: location.longitude,
                        ),
                ),
              ],
            ),
          );
        });
  }
}
