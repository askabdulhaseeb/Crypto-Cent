import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  Review({
    required this.reviewID,
    required this.customerUID,
    required this.sellerUID,
    required this.productID,
    required this.timestamp,
    required this.rating,
    required this.comment,
  });

  final String reviewID;
  final String customerUID;
  final String sellerUID;
  final String productID;
  final int timestamp;
  final double rating;
  final String comment;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'review_id': reviewID,
      'customer_uid': customerUID,
      'seller_uid': sellerUID,
      'product_id': productID,
      'timestamp': timestamp,
      'rating': rating,
      'comment': comment,
    };
  }

  // ignore: sort_constructors_first
  factory Review.fromMap(DocumentSnapshot <Map<String, dynamic>> doc) {
    return Review(
      reviewID: doc.data()?['review_id'] ?? '',
      customerUID: doc.data()?['customer_uid'] ?? '',
      sellerUID: doc.data()?['seller_uid'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
      rating: doc.data()?['rating'] ?? 0.0,
      comment: doc.data()?['comment'] ?? '',
      productID: doc.data()?['product_id']??'',
      
    );
  }
}
