import 'package:flutter/cupertino.dart';

import '../database/app_user/auth_method.dart';
import '../database/review_api.dart';
import '../function/time_date_function.dart';
import '../models/payment/orderd_product.dart';
import '../models/product/product_model.dart';
import '../models/review.dart';

class RatingProvider with ChangeNotifier {
  TextEditingController ratingComment = TextEditingController(text: '');
  double rating = 1;
  Future<bool> uploadRating(OrderdProduct product) async {
    Review review = Review(
        reviewID: TimeStamp.timestamp.toString() + AuthMethods.uid,
        customerUID: AuthMethods.uid,
        sellerUID: product.sellerID,
        timestamp: TimeStamp.timestamp,
        rating: rating,
        comment: ratingComment.text,
        productID: product.pid);
    bool temp = await ReviewApi().add(review);
    if (temp) {
      print('ok');
    }
    return temp;
  }
}
