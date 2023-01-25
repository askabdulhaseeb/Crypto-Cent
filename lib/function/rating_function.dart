import '../models/review.dart';

class ReviewFunction {
  double rating(List<Review> value) {
    int i = 0;
    double total = 0;
    for (; i < value.length; i++) {
      total += value[i].rating;
    }
    return i == 0 ? 0 : total / i;
  }
}
