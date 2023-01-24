import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/review.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class ReviewApi {
   final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'review';

   Future<bool> add(Review value) async {
    try {
      await _instance
          .collection(_collection)
          .doc(value.reviewID)
          .set(value.toMap());
      // CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }
}