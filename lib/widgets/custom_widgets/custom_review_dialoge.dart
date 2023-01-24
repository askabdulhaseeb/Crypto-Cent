import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../models/product/product_model.dart';
import '../../providers/rating_provider.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import 'custom_elevated_button.dart';
import 'custom_textformfield.dart';

class CustomReviewDialogBox extends StatefulWidget {
  const CustomReviewDialogBox({
   // required this.product,
    Key? key,
  }) : super(key: key);
  //final Product product;

  @override
  _CustomReviewDialogBoxState createState() => _CustomReviewDialogBoxState();
}

class _CustomReviewDialogBoxState extends State<CustomReviewDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Consumer<RatingProvider>(
              builder: (context, RatingProvider ratingPro, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ratingBar(ratingPro),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  controller: ratingPro.ratingComment,
                  hint: 'Comment',
                  maxLength: 500,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomElevatedButton(
                    onTap: () {},
                    title: 'Review',
                  ),
                ),
              ],
            );
          }),
        ),
        Positioned(
          left: 60,
          right: 60,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.avatarRadius)),
                child: Image.asset(AppImages.logo)),
          ),
        ),
      ],
    );
  }

  RatingBar ratingBar(RatingProvider ratingPro) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (BuildContext context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double rating) {
        ratingPro.rating = rating;
      },
    );
  }
}
