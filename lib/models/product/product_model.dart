import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_url.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String pid;
  final double amount;
  final String colors;
  final String quantity;
  final String productname;
  final String description;
  final int timestamp;
  final String category;
  final String subCategory;
  final String createdByUID;
  late List<ProductURL> prodURL;
  Product({
    required this.pid,
    required this.amount,
    required this.colors,
    required this.quantity,
    required this.productname,
    required this.description,
    required this.timestamp,
    required this.category,
    required this.subCategory,
    required this.createdByUID,
    required this.prodURL,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'amount': amount,
      'colors': colors,
      'quantity': quantity,
      'description': description,
      'timestamp': timestamp,
      'category': category,
      'sub_category': subCategory,
      'created_by_uid': createdByUID,
      'product_name': productname,
      'prod_urls': prodURL.map((ProductURL e) => e.toMap()).toList(),
    };
  }

  factory Product.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<ProductURL> prodURL = <ProductURL>[];
    final dynamic data = doc.data()!['prod_urls'];
    if (data == null) {
      prodURL.add(
        ProductURL(url: doc.data()!['image_url'], isVideo: false, index: 0),
      );
    } else {
      doc.data()!['prod_urls'].forEach((dynamic e) {
        prodURL.add(ProductURL.fromMap(e));
      });
    }
    return Product(
      pid: doc.data()?['pid'] ?? '',
      amount: doc.data()?['amount'] ?? 0,
      colors: doc.data()?['colors'] ?? '',
      quantity: doc.data()?['quantity'] ?? '',
      description: doc.data()?['description'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? '',
      category: doc.data()?['category'] ?? '',
      subCategory: doc.data()?['sub_category'] ?? '',
      createdByUID: doc.data()?['created_by_uid'] ?? '',
      productname: doc.data()?['product_name'],
      prodURL: prodURL,
    );
  }
}
