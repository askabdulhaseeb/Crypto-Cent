import 'package:flutter/cupertino.dart';

import '../database/app_user/auth_method.dart';
import '../database/review_api.dart';
import '../function/time_date_function.dart';
import '../models/payment/orderd_product.dart';
import '../models/review.dart';

class RatingProvider with ChangeNotifier {
  RatingProvider() {
    load();
  }

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
      debugPrint('ok');
    }
    return temp;
  }

  Future<void> load() async {
    _review = await ReviewApi().getdata();
    notifyListeners();
  }

  List<Review> productReviews(String uid) {
    print('chala ha');
    List<Review> currentReview =
        _review.where((Review e) => e.productID == uid).toList();
    return currentReview;
  }
  List<Review> userReviews(String uid) {
    List<Review> currentReview =
        _review.where((Review e) => e.sellerUID == uid).toList();
    return currentReview;
  }
  clear() {
    rating = 1;
    ratingComment.clear();
  }

  TextEditingController ratingComment = TextEditingController(text: '');
  double rating = 1;
  List<Review> _review = <Review>[];
  List<Review> get review => _review;
}
