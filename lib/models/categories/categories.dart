import 'package:cloud_firestore/cloud_firestore.dart';
import 'sub_categories.dart';

class Categories {
  Categories({
    required this.catID,
    required this.title,
    required this.status,
    required this.imageURl,
    required this.subCategories,
  });

  final String catID;
  final String title;
  final bool status;
  final String imageURl;
  final List<SubCategory> subCategories;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cat_id': catID,
      'title': title,
      'status': status,
      'image_url': imageURl,
      'sub_categories':
          subCategories.map((SubCategory x) => x.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory Categories.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<SubCategory> subCats = <SubCategory>[];
    final List<dynamic> data = doc.data()?['sub_categories'] ?? [];
    for (dynamic element in data) {
      subCats.add(SubCategory.fromMap(element));
    }
    return Categories(
      catID: doc.data()?['cat_id'] ?? '',
      imageURl: doc.data()?['image_url'] ?? '',
      title: doc.data()?['title'] ?? '',
      status: doc.data()?['status'] ?? '',
      subCategories: subCats,
    );
  }
}
