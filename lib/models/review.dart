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
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewID: map['review_id'] ?? '',
      customerUID: map['customer_uid'] ?? '',
      sellerUID: map['seller_uid'] ?? '',
      timestamp: map['timestamp'] ?? 0,
      rating: map['rating'] ?? 0.0,
      comment: map['comment'] ?? '',
      productID: map['product_id'],
      
    );
  }
}
