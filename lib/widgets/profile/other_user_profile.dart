import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../providers/provider.dart';
import '../../database/app_user/auth_method.dart';
import '../../function/rating_function.dart';
import '../../function/report_bottom_sheets.dart';
import '../../models/app_user/app_user.dart';
import '../../models/product/product_model.dart';
import '../../models/review.dart';
import '../../providers/rating_provider.dart';
import '../../screens/reviews/review_screen.dart';
import '../custom_widgets/custom_rating_star.dart';
import '../custom_widgets/cutom_text.dart';
import '../product/extend_product_tile/extend_product_tile.dart';
import 'profile_header.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({required this.appUser, super.key});
  final AppUser appUser;
  @override
  Widget build(BuildContext context) {
    ProductProvider prouctPro = Provider.of<ProductProvider>(context);
    List<Product> products = <Product>[];
    List<Review> reviews =
        Provider.of<RatingProvider>(context).userReviews(appUser.uid);
    products = prouctPro.productByUID(appUser.uid);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text(appUser.name!),
        actions: <Widget>[
          if (AuthMethods.uid.isNotEmpty)
            IconButton(
                onPressed: () => ReportBottomSheets()
                    .otherUserProfileMoreButton(context, appUser),
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              color: Theme.of(context).secondaryHeaderColor,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: appUser.imageURL!.isEmpty
                        ? null
                        : NetworkImage(appUser.imageURL!),
                    child: appUser.imageURL!.isEmpty
                        ? const Icon(Icons.person, size: 80, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      await HapticFeedback.heavyImpact();
                      Navigator.push(
                          context,
                          MaterialPageRoute<ReviewScreen>(
                            builder: (BuildContext context) => ReviewScreen(
                              reviews: reviews,
                              isProduct: false,
                              id: appUser.uid,
                            ),
                          ));
                    },
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomRatingBar(
                          itemSize: 24,
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
                ],
              ),
            ),
            tilewidget(
              context: context,
              text: 'Reviews',
              icon: Icons.reviews,
              onTap: () async {
                await HapticFeedback.heavyImpact();
                Navigator.push(
                    context,
                    MaterialPageRoute<ReviewScreen>(
                      builder: (BuildContext context) => ReviewScreen(
                        reviews: reviews,
                        isProduct: false,
                        id: appUser.uid,
                      ),
                    ));
              },
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.count(
                childAspectRatio: 200 / 340,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                shrinkWrap: true,
                primary: false,
                children: List<Widget>.generate(products.length, (int index) {
                  return ExtendProductTile(product: products[index]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tilewidget({
    BuildContext? context,
    String? text,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffF6F7F9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon!,
            color: Theme.of(context!).primaryColor,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              ForText(
                name: text!,
                bold: true,
              ),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
