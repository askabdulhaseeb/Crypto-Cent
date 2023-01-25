// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../function/rating_function.dart';
import '../../models/app_user/app_user.dart';
import '../../models/product/product_model.dart';
import '../../models/review.dart';
import '../../providers/provider.dart';
import '../../widgets/custom_widgets/custom_network_image.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/custom_widgets/custom_rating_star.dart';
import '../../widgets/custom_widgets/cutom_text.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    required this.reviews,
    required this.id,
    this.isProduct = false,
    Key? key,
  }) : super(key: key);
  final List<Review> reviews;
  final bool isProduct;
  final String id;
  final String text =
      'In the final or concluding paragraph, you need to summarize the key points of your essay and restate your main claim.Writing a 500 words essay, along with writing a five-paragraph essay, is one of the common assignments assigned to middle and high school students. Writing a 500 words essay is no easy feat and requires careful planning in order to concisely convey your argument. You should focus on the following three areas: You should focus on the following three areas: You shouldgsgg vggfvfb fg';
  @override
  Widget build(BuildContext context) {
    final UserProvider userPro =
        Provider.of<UserProvider>(context, listen: false);
    ProductProvider prodPro =
        Provider.of<ProductProvider>(context, listen: false);
    late Product appProduct;
    late AppUser appUser;
    if (isProduct) {
      appProduct = prodPro.product(id);
    } else {
      appUser = userPro.user(id);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            CustomProfileImage(
                imageURL:
                    isProduct ? appProduct.prodURL[0].url : appUser.imageURL),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isProduct ? const Text('PRODUCT') : Text(appUser.name!),
                Text(
                  'Total Reviews: ${reviews.length}'.toUpperCase(),
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (BuildContext context, int index) {
            final Product product = prodPro.product(reviews[index].productID);
            final AppUser user = userPro.user(reviews[index].customerUID);
            String imageURL = user.imageURL!;
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomProfileImage(imageURL: imageURL),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              user.name!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                            CustomRatingBar(
                              itemSize: 20,
                              initialRating: reviews[index].rating,
                              onRatingUpdate: (_) {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      isProduct == false
                          ? Container(
                              height: 50,
                              width: 50,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12)),
                              child: CustomNetworkImage(
                                  imageURL: product.prodURL[0].url),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    reviews[index].comment,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            );
          }),
    );
  }
}
