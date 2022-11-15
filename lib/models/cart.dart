class Cart {
  Cart({
    required this.id,
    required this.title,
    required this.imageurl,
    required this.price,
    required this.createdID,
    required this.quantity,
    required this.exchangeRate,
  });
  final String id;
  final String createdID;
  final String title;
  final String imageurl;
  final double price;
  final double exchangeRate;
  int quantity;
}
