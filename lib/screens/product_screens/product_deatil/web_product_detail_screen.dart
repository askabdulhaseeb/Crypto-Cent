import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../providers/cart_provider.dart';
import '../../../../widgets/custom_widgets/custom_rating_star.dart';
import '../../../../widgets/custom_widgets/custom_widget.dart';
import '../../../database/app_user/auth_method.dart';
import '../../../database/chat_api.dart';
import '../../../function/crypto_function.dart';
import '../../../function/rating_function.dart';
import '../../../function/report_bottom_sheets.dart';
import '../../../function/unique_id_functions.dart';
import '../../../function/web_appbar.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/chat/chat.dart';
import '../../../models/location.dart';
import '../../../models/product/product_model.dart';
import '../../../models/review.dart';
import '../../../providers/location_provider.dart';
import '../../../providers/rating_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_dialog.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/custom_toast.dart';
import '../../../widgets/custom_widgets/footer_widget.dart';
import '../../../widgets/custom_widgets/promo_widget.dart';
import '../../../widgets/product/add_to_cart_widget.dart';
import '../../../widgets/product/latest_Product/latest_product.dart';
import '../../../widgets/product/product_url_slider.dart';
import '../../../widgets/product/send_offer_widget.dart';
import '../../chat_screen/private/personal_chat_screen.dart';
import '../../chat_screen/private/product_chat_screen.dart';
import '../../../widgets/profile/other_user_profile.dart';
import '../../map_screen/map_screen.dart';
import '../../reviews/review_screen.dart';

class WebProductDetailScreen extends StatefulWidget {
  const WebProductDetailScreen({required this.product, super.key});
  final Product product;
  @override
  State<WebProductDetailScreen> createState() => _WebProductDetailScreenState();
}

class _WebProductDetailScreenState extends State<WebProductDetailScreen> {
  @override
int quantity = 1;
  Widget build(BuildContext context) {
    final AppUser seller =
        Provider.of<UserProvider>(context).user(widget.product.uid);
    CartProvider cartPro = Provider.of<CartProvider>(context);
    LocationProvider locationPro = Provider.of<LocationProvider>(context);
    final UserLocation location =
        locationPro.productLocation(widget.product.locationUID);

    List<Review> reviews =
        Provider.of<RatingProvider>(context).productReviews(widget.product.pid);
        // double height=MediaQuery.of(context).size.height;
        // double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WebAppBar.webAppBar,
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 25),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
                child: Column(
                  children: [
                    Row(
                   
                      children: [
                        Expanded(child: WebProductURLsSlider(urls:widget.product.prodURL,)),
                       const SizedBox(width: 50,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            reviewWidget(context, reviews),
                            const SizedBox(height: 20,),
                             Text(
                                  widget.product.productname,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                 Text(
                                          '\$ ${widget.product.amount}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                          ),
                                        ),
                                        const SizedBox(height: 20,),
                                         addToCartWidget(context),
                                        const SizedBox(height: 20,),
                                        
                                       SizedBox(
                                        height: 300,
                                        width: 300,
                                         child: ExpansionTile(
                                          
                                                 title: const Text('Description'),
                                                 trailing:  Icon(Icons.add),
                                                 children: <Widget>[
                                                   ListTile(title: Text(widget.product.description)),
                                                 ],
                                               ),
                                       ),
                                        const SizedBox(height: 20,),
                                        const Divider(color: Colors.grey,thickness: 2,),
                                     
                          ],
                        ),
                      ],
                    ),
                 
                  ],
                ),
              ),
                   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const ForText(
                    name: 'Popular Products',
                    bold: true,
                    size: 18,
                  ),
                  TextButton(
                    onPressed: (() {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute<CategoriesExtend>(
                      //         builder: (BuildContext context) =>
                      //             CategoriesExtend(categoryName: 'All')));
                    }),
                    child: ForText(
                      name: 'View All',
                      color: Theme.of(context).primaryColor,
                      bold: true,
                    ),
                  ),
                ],
              ),
        ),
        const SizedBox(
              height: 10,
        ),
        const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: LatestProductsList(),
        ), 
       const SizedBox(height: 40,),
        const SizedBox(height: 20),
            PromoWidget(),
            const FooterWidget(),
            ],
          ),
        ),
      )),
    );
  }

  Row addToCartWidget(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: quantity < 2
                    ? null
                    : () {
                        setState(() {
                          quantity--;
                        });
                      },
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 24,
                  color: quantity < 2 ? Colors.grey : Colors.red,
                ),
              ),
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                onPressed: quantity >= int.parse(widget.product.quantity)
                    ? null
                    : () {
                        setState(() {
                          quantity++;
                        });
                      },
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 24,
                  color: quantity >= int.parse(widget.product.quantity)
                      ? Colors.grey
                      : Colors.green,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              child: const ForText(name: 'Add To cart',color: Colors.white,),
              )
            ],
          );
  }

  Row reviewWidget(BuildContext context, List<Review> reviews) {
    return Row(
                children: [
                  const ForText(name: 'Popular Product',textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                  )),
                  const SizedBox(width: 100,),
                  GestureDetector(
                        onTap: () async {
                          await HapticFeedback.heavyImpact();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute<ReviewScreen>(
                                builder: (BuildContext context) =>
                                    ReviewScreen(
                                  reviews: reviews,
                                  isProduct: true,
                                  id: widget.product.pid,
                                ),
                              ));
                        },
                        child: 
                            CustomRatingBar(
                              itemSize: 20,
                              initialRating: ReviewFunction().rating(reviews),
                              onRatingUpdate: (_) {},
                            ),
                            
                      ),
                ],
              );
  }

  GestureDetector userDetails(BuildContext context, AppUser seller) {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.heavyImpact();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute<WebProductDetailScreen>(
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

class messages extends StatelessWidget {
  const messages({
    super.key,
    required this.mounted,
    required this.seller,
  });

  final bool mounted;
  final AppUser seller;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      child: IconButton(
        onPressed: () async {
          if (!mounted) return;
          Navigator.of(context).push(
            MaterialPageRoute<PersonalChatScreen>(
              builder: (BuildContext context) => PersonalChatScreen(
                chat: Chat(
                    chatID:
                        UniqueIdFunctions.personalChatID(chatWith: seller.uid),
                    persons: <String>[seller.uid, AuthMethods.uid]),
                chatWith: seller,
              ),
            ),
          );
        },
        icon: Icon(Icons.chat, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
